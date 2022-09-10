#!/bin/bash

if [[ -n "$_manual_procedures_sh" ]]; then
  return
fi
_manual_procedures_sh=1

source constants.sh

if [[ -z "$_manual_procedures_file_name" ]]; then
  readonly _manual_procedures_file_name="manual-procedures.txt"
fi

if [[ -z "$_manual_procedures_file_path" ]]; then
  readonly _manual_procedures_file_path="$_temporary_directory/$_manual_procedures_file_name"
fi

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
