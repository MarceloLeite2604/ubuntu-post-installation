#!/bin/bash

if [[ -n "$_history_sh" ]]; then
  return
fi
_history_sh=1

source constants.sh

if [[ -z "$_history_file" ]]; then
  readonly _history_file="$_temporary_directory/.history"
fi

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
