#!/bin/bash

# Include guard
[ -n "$_PROPERTIES_SH" ] && return || readonly _PROPERTIES_SH=1;

load_properties() {
  local readonly file_path=$1;

  if [[ ! -f "$file_path" ]]; then
    log_error "File \"$file_path\" not found."
    return $FAILURE;
  fi;

  while read property; do
    name=${property%%=*};
    value=${property/$name=/};
    log_debug "Loading property \"$name\" with value \"$value\" for task \"$task\".";
    eval export readonly $property;
  done <$file_path;
}

unload_properties() {
  local readonly file_path=$1;

  if [[ ! -f "$file_path" ]]; then
    log_error "File \"$file_path\" not found."
    return $FAILURE;
  fi;

  while read property; do
    name=${property%%=*};
    eval unset $name;
  done <$file_path;
}