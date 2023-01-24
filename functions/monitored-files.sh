#!/bin/bash

if [[ -n "$_monitores_files_sh" ]]; then
  return
fi
_monitored_files_sh=1

_script_directory=$(dirname "${BASH_SOURCE[0]}")

source "$_script_directory"/log.sh
source "$_script_directory"/checksum.sh

if [[ ! -v ${_monitored_files[*]} ]]; then
  _monitored_files=(
    "$HOME/.bashrc"
  )
  readonly _monitored_files;
fi;

function _save_file_state() {
  local file;
  file=$(readlink -f "$1");
  readonly file;
  _save_checksum "$file";
}

function _save_monitored_files_state() {
  for monitored_file in "${_monitored_files[@]}"; do
    _save_file_state "$monitored_file";
  done
}

function _reload_monitored_files() {
  for monitored_file in "${_monitored_files[@]}"; do
    if _verify_checksum_differs "$monitored_file"; then
      _log "File \"$monitored_file\" has been updated. Reloading it." "$_log_level_info" "$_log_no_header";
      # shellcheck source=/dev/null
      source "$monitored_file";
      _save_file_state "$monitored_file"
    fi;
  done
}