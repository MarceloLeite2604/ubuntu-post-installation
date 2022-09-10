#!/bin/bash

if [[ $(id -u) -ne 0 || -z "$USERNAME" ]]; then
  echo >&2 "This script must be executed by using \"sudo\" and preserving the environment variables (-E flag)."
  echo >&2 "Please execute this script through \"sudo -E\" command."
  exit 1
fi

_debug=1
_reset_history=1

while getopts dr flag; do
  case $flag in
  d)
    _debug=0
    ;;
  r)
    _reset_history=0
    ;;
  *)
    echo >&2 "Invalid flag: $flag"
    exit 1
    ;;
  esac
done

if [[ $_debug -eq 0 ]]; then
  set -x
fi

_scripts_root=$(dirname "$0")
readonly _scripts_root

# shellcheck source=./functions.sh
source "$_scripts_root/functions.sh"

if [[ $_reset_history -eq 0 ]]; then
  _clear_history
  _clear_manual_procedures_file
fi

function _check_skip_execution() {
  _retrieve_history "$script"
  local previous_execution=$?

  case $previous_execution in
  0)
    echo "[$script] Skipped (previously executed)"
    return 1
    ;;
  1)
    echo "[$script] Retrying"
    ;;
  *) ;;

  esac
  return 0
}

function _run_script() {
  local script="$1"

  _check_skip_execution || return 0

  _clear_context

  _load "$script" || return 1

  _check_context || return 1

  _setUp

  if ! _verify; then
    echo "[$script] Skipped (no changes are necessary)"
    _tearDown
    return 0
  fi

  echo "[$script] $_description"

  _execute
  local _execution_result=$?

  _tearDown

  if [[ $_execution_result -ne 0 ]]; then
    echo >&2 "[$script] Failed"
    return 1
  fi

  if [[ $(type -t _manual_procedures) == function ]]; then
    local content
    content="$(_manual_procedures)"
    _add_manual_procedures "[$script] $content"
  fi

  echo "[$script] Complete."
  return 0
}

function _search_scripts() {
  find "$_scripts_root" -type f -regex ".*/[0-9]+-[A-z0-9-]+\.sh" | sort | xargs echo
}

function _run() {
  for script in $(_search_scripts); do
    _run_script "$script"
    _result=$?
    _add_history "$script" $_result
    if [[ _result -ne 0 ]]; then
      echo >&2 "Cancelling execution."
      return 1
    fi
  done

  echo "Execution completed."
  return 0
}

function _print_manual_procedures() {
  local _manual_procedures_content;
  _manual_procedures_content=$(_read_manual_procedures)

  if [[ -n "$_manual_procedures_content" ]]; then
    echo "Additional procedures that must be done manually.";
    echo "$_manual_procedures_content"
  fi;
}

_run
_print_manual_procedures

if [[ $_debug -eq 0 ]]; then
  set +x
fi
