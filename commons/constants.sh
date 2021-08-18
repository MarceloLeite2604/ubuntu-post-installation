#!/bin/bash

# Include guard
[ -n "$_CONSTANTS_SH" ] && return || readonly _CONSTANTS_SH=1;

# Exit/return codes
SUCCESS=0
FAILURE=255
SKIP=254

load_constants() {
  local file_path=$1;

  if [[ -f $file_path ]]; then
    log_error "File \"$file_path\" not found."
    return $FAILURE;
  fi;

  while read property; do
    eval export readonly $property;
  done <$file_path;
}

unload_constants() {
  local file_path=$1;

  if [[ -f $file_path ]]; then
    log_error "File \"$file_path\" not found."
    return $FAILURE;
  fi;

  while read property; do
    var_name=${property%=*};
    eval unset $var_name;
  done <$file_path;
}