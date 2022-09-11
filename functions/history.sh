#!/bin/bash

if [[ -n "$_history_sh" ]]; then
  return
fi
_history_sh=1

_script_directory=$(dirname "${BASH_SOURCE[0]}")

source "$_script_directory"/constants.sh
source "$_script_directory"/log.sh

if [[ -z "$_history_file" ]]; then
  readonly _history_file="$_temporary_directory/.history"
fi

function _create_history_file() {
  if [[ ! -f "$_history_file" ]]; then
    mkdir -p "$_temporary_directory";
    touch "$_history_file"
  fi;
}

function _clear_history() {
  _create_history_file
  _log "Clearing execution history." "INFO" "$_log_no_header"
  echo -n "" >"$_history_file"
}

function _add_history() {
  local step_script="$1"
  local result="$2"
  echo "$step_script $result" >>"$_history_file"
}

function _retrieve_history() {
  local step_script="$1"

  if [[ ! -f $_history_file ]]; then
    touch "$_history_file"
    return 0
  fi

  local content
  content=$(grep "$step_script" "$_history_file")

  if [ -z "$content" ]; then
    return 2
  else
    return "${content##* }"
  fi
}
