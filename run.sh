#!/bin/bash

_root_directory=$(dirname "${BASH_SCRIPT[0]}")
readonly _root_directory

source "$_root_directory"/functions/arguments.sh

_check_arguments "$@" || exit 1

if [[ $UPI_DEBUG -eq 0 ]]; then
  set -x
fi

for source_file in "$_root_directory"/functions/*.sh; do
  # shellcheck source=/dev/null
  source "$source_file"
done

if [[ $(id -u) -ne 0 || -z "$USERNAME" ]]; then
  # shellcheck disable=SC2154
  _log "This script must be executed by using \"sudo\" and preserving the environment variables (-E flag)." "ERROR" "$_log_no_header"
  _log "Please execute this script through \"sudo -E\" command." "ERROR" "$_log_no_header"
  exit 1
fi

if [[ $UPI_RESET_EXECUTION -eq 0 ]]; then
  _clear_history
  _clear_manual_procedures_file
fi

_create_history_file
_create_cache_directory

function _search_step_scripts() {
  find "$_root_directory" -type f -regex "\./steps/.*/[0-9]+-[a-Z0-9-]+\.sh" | sort | xargs echo
}

function _print_manual_procedures() {
  local _manual_procedures_content
  _manual_procedures_content=$(_read_manual_procedures)

  if [[ -n "$_manual_procedures_content" ]]; then
    _log "Additional procedures that must be done manually." "INFO" "$_log_no_header"
    echo "$_manual_procedures_content"
  fi
}

function _run() {
  for step_script in $(_search_step_scripts); do
    bash step.sh "$step_script"
    _result=$?
    _add_history "$step_script" $_result
    if [[ _result -ne 0 ]]; then
      _log "Cancelling execution." "ERROR" "$_log_no_header"
      return 1
    fi
  done

  _print_manual_procedures
  _log "Execution completed." "INFO" "$_log_no_header"
  return 0
}

_run

if [[ $UPI_DEBUG -eq 0 ]]; then
  set +x
fi
