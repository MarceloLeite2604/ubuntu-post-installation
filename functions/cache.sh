#!/bin/bash

if [[ -n "$_cache_sh" ]]; then
  return
fi
_cache_sh=1

_script_directory=$(dirname "${BASH_SOURCE[0]}")

source "$_script_directory"/constants.sh

function _create_cache_directory() {
  mkdir -p "$_cache_directory";
}

function _clear_cache_directory() {
  rm -rf "${_cache_directory:?}/*";
}

function _delete_cache_directory() {
  rm -rf "${_cache_directory:?}";
}