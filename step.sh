#!/bin/bash

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
  local message_prefix="[$script_location]"

  _retrieve_history "$script_location"
  local previous_execution=$?

  case $previous_execution in
  0)
    echo "$message_prefix Skipped (previously executed)"
    return 0
    ;;
  1)
    echo "$message_prefix Retrying"
    return 1
    ;;
  *)
    echo >&2 "$message_prefix Invalid code on execution history ($previous_execution). Step will be reexecuted."
    return 1
    ;;
  esac
}

function _execute_step() {
  local script_location="$1"
  local message_prefix="[$script_location]"

  _check_step_was_previously_executed "$script_location" || return 0

  # _clear_context

  _load "$script_location" || return 1

  _check_context || return 1

  _set_up

  if ! _check_step_is_necessary; then
    echo "$message_prefix Skipped (no changes are necessary)"
    _tearDown
    return 0
  fi

  # shellcheck disable=SC2154
  echo "$message_prefix $_description"

  _execute
  local _execution_result=$?

  _tearDown

  if [[ $_execution_result -ne 0 ]]; then
    echo >&2 "$message_prefix Failed"
    return 1
  fi

  if [[ $(type -t _manual_procedures) == function ]]; then
    local content
    content="$(_manual_procedures)"
    _add_manual_procedures "$message_prefix $content"
  fi

  echo "$message_prefix Complete."
  return 0
}

_execute_step "$1"