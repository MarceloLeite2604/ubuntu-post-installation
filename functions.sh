#!/bin/bash

if [[ -n "$_FUNCTIONS_SH" ]]; then
  return
fi
_FUNCTIONS_SH=1

if [[ -z "$_scripts_root" ]]; then
  _scripts_root=$(dirname "$0")
  readonly _scripts_root
fi

if [[ -z "$_temporary_directory" ]]; then
  readonly _temporary_directory="/tmp/ubuntu-post-installation"
fi

if [[ -z "$_manual_procedures_file_name" ]]; then
  readonly _manual_procedures_file_name="manual-procedures.txt"
fi

if [[ -z "$_manual_procedures_file_path" ]]; then
  readonly _manual_procedures_file_path="$_temporary_directory/$_manual_procedures_file_name"
fi

readonly _history_file="$_scripts_root/.history"

function _clear_history() {
  echo "Clearing execution history."
  echo -n "" >"$_history_file"
}

function _add_history() {
  local script="$1"
  local result="$2"
  echo "$script $result" >>"$_history_file"
}

function _retrieve_history() {
  local script="$1"

  if [[ ! -f $_history_file ]]; then
    touch "$_history_file"
    return 0
  fi

  local content
  content=$(grep "$script" "$_history_file")

  if [ -z "$content" ]; then
    return 2
  else
    return "${content##* }"
  fi
}

function _clear_context() {
  unset _description
  unset -f _setUp
  unset -f _verify
  unset -f _execute
  unset -f _tearDown
  unset -f _manual_procedures
}

function _check_context() {
  if [[ -z "$_description" ]]; then
    echo >&2 "\"_description\" variable is not set."
    return 1
  fi

  if [[ $(type -t _setUp) != function ]]; then
    echo >&2 "\"_setUp\" function is not set."
    return 1
  fi

  if [[ $(type -t _verify) != function ]]; then
    echo >&2 "\"_verify\" function is not set."
    return 1
  fi

  if [[ $(type -t _execute) != function ]]; then
    echo >&2 "\"_execute\" function is not set."
    return 1
  fi

  if [[ $(type -t _tearDown) != function ]]; then
    echo >&2 "\"_tearDown\" function is not set."
    return 1
  fi

  return 0
}

function _load() {
  local script="$1"

  if [[ ! -f "$script" ]]; then
    echo >&2 "Could not find script \"$script\"."
    return 1
  fi

  # shellcheck source=/dev/null
  source "$script"
  return 0
}

function _create_manual_procedures_file() {
  if [[ ! -f "$_manual_procedures_file_path" ]]; then
    mkdir -p "$_temporary_directory"
    touch "$_manual_procedures_file_path"
  fi
}

function _clear_manual_procedures_file() {
  if [[ -f "$_manual_procedures_file_path" ]]; then
    rm -f "$_manual_procedures_file_path";
  fi;
}

function _add_manual_procedures() {
  local content="$1"

  _create_manual_procedures_file
  echo "$content" >>"$_manual_procedures_file_path"
}

function _read_manual_procedures() {
  if [[ -f "$_manual_procedures_file_path" ]]; then
    cat "$_manual_procedures_file_path"
  fi;
}
