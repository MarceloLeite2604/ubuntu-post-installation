#!/bin/bash

if [[ $UPI_DEBUG -eq 0 ]]; then
  set -x
fi

if [[ -n "$_step_sh" ]]; then
  return
fi
_step_sh=1

_root_directory=$(dirname "$0")
readonly _root_directory

for source_file in "$_root_directory"/functions/*.sh; do
  # shellcheck source=/dev/null
  source "$source_file"
done

function _check_step_was_previously_executed() {
  local script_location="$1"

  _retrieve_history "$script_location"
  local previous_execution=$?

  case $previous_execution in
  0)
    _log "Skipped (previously executed)"
    return 0
    ;;
  1)
    _log "Retrying"
    return 1
    ;;
  2)
    return 1
    ;;
  *)
    # shellcheck disable=SC2154
    _log "Invalid code on execution history ($previous_execution). Step will be reexecuted." "WARN" "$_log_no_header"
    return 1
    ;;
  esac
}

function _load() {
  local step_script="$1"

  if [[ ! -f "$step_script" ]]; then
    _log "Could not find script \"$step_script\"." "ERROR" "$_log_no_header"
    return 1
  fi

  # shellcheck source=/dev/null
  source "$step_script"
  return 0
}

function _execute_step() {
  local script_location="$1"
  _set_log_header "$script_location"

  _check_step_was_previously_executed "$script_location" && return 0

  _load "$script_location" || return 1

  _check_context || return 1

  if ! _check_step_is_necessary; then
    _log "Skipped (no changes are necessary)"
    return 0
  fi

  # shellcheck disable=SC2154
  _log "$_description"

  _execute
  local _execution_result=$?

  if [[ $_execution_result -ne 0 ]]; then
    _log "Failed" "ERROR"
    return 1
  fi

  if [[ $(type -t _manual_procedures) == function ]]; then
    local content
    content="$(_manual_procedures)"
    _add_manual_procedures "$script_location $content"
  fi

  _clear_log_header
  return 0
}

_execute_step "$1"

if [[ $UPI_DEBUG -eq 0 ]]; then
  set +x
fi
