#!/bin/bash

if [[ $(id -u) -ne 0 || -z "$USERNAME" ]]; then
  echo >&2 "This script must be executed by using \"sudo\" and preserving the environment variables (-E flag)."
  echo >&2 "Please execute this script through \"sudo -E\" command."
  exit 1
fi

_root_directory=$(dirname "${BASH_SCRIPT[0]}")
readonly _root_directory

source "$_root_directory"/functions/arguments.sh

_check_arguments "$@"

if [[ $UPI_DEBUG -eq 0 ]]; then
  set -x
fi

for source_file in "$_root_directory"/functions/*.sh; do
  # shellcheck source=/dev/null
  source "$source_file"
done

if [[ $UPI_RESET_EXECUTION -eq 0 ]]; then
  _clear_history
  _clear_manual_procedures_file
fi

function _search_step_scripts() {
  find "$_root_directory" -type f -regex "\./steps/.*/[0-9]+-[A-z0-9-]+\.sh" | sort | xargs echo
}

function _print_manual_procedures() {
  local _manual_procedures_content
  _manual_procedures_content=$(_read_manual_procedures)

  if [[ -n "$_manual_procedures_content" ]]; then
    echo "Additional procedures that must be done manually."
    echo "$_manual_procedures_content"
  fi
}

function _run() {
  for step_script in $(_search_step_scripts); do
    bash step.sh "$step_script"
    _result=$?
    _add_history "$step_script" $_result
    if [[ _result -ne 0 ]]; then
      echo >&2 "Cancelling execution."
      return 1
    fi
  done

  _print_manual_procedures
  echo "Execution completed."
  return 0
}

_run

if [[ $UPI_DEBUG -eq 0 ]]; then
  set +x
fi
