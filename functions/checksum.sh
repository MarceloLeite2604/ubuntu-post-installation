#!/bin/bash

if [[ -n "$_checksum_sh" ]]; then
  return
fi
_checksum_sh=1

_script_directory=$(dirname "${BASH_SOURCE[0]}")

source "$_script_directory"/constants.sh

_checksum_file="$_temporary_directory/checksums";
readonly _checksum_file;

_cksum_bin=$(which cksum);
if [[ -z "$_cksum_bin" ]]; then
  >&2 echo "Could not find \"cksum\" binary. Please install is with \"sudo apt install -y coreutils\" command.";
  exit 1;
fi;
readonly _cksum_bin;

_create_checksum_file() {
  if [ ! -f "$_checksum_file" ]; then
    mkdir -p "$(dirname "$_checksum_file")";
    touch "$_checksum_file";
  fi;
}

_save_checksum() {
  local file_path;
  file_path="$(readlink -f "$1")";
  readonly file_path;

  if [[ -f "$file_path" ]]; then

    _create_checksum_file;

    grep -v "$file_path" "$_checksum_file"  > "$_checksum_file.tmp";
    mv "$_checksum_file.tmp" "$_checksum_file";
    "$_cksum_bin" "$file_path" >> "$_checksum_file";
  fi;
}

_retrieve_checksum() {
  local file_path;
  file_path="$(readlink -f "$1")";
  readonly file_path;

  _create_checksum_file;
  grep "$file_path" "$_checksum_file"; 
}

_verify_checksum_differs() {
  local file_path="$1";
  readonly file_path;

  stored_checksum=$(_retrieve_checksum "$file_path");
  file_checksum=$("$_cksum_bin" "$file_path");

  [[ ! "$stored_checksum" == "$file_checksum" ]];
}

_delete_checksum_file() {
  rm -f "$_checksum_file";
}