#!/bin/bash

if [[ $(id -u) -ne 0 || -z "$USERNAME" ]]; then
  echo >&2 "This script must be executed by using \"sudo\" and preserving the environment variables (-E flag)."
  echo >&2 "Please execute this script through \"sudo -E\" command."
  exit 1
fi

_debug=1
_reset_execution=1

while getopts dr flag; do
  case $flag in
  d)
    _debug=0
    ;;
  r)
    _reset_execution=0
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

_root_directory=$(dirname "$0")
readonly _root_directory

for source_file in "$_root_directory"/functions/*.sh; do
  # shellcheck source=/dev/null
  source "$source_file"
done

if [[ $_reset_execution -eq 0 ]]; then
  _clear_history
  _clear_manual_procedures_file
fi

function _search_step_scripts() {
  # TODO Check regex
  find "$_root_directory" -type f -regex ".*/steps/[0-9]+-[A-z0-9-]+\.sh" | sort | xargs echo
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
    #_run_script "$script"
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

if [[ $_debug -eq 0 ]]; then
  set +x
fi
