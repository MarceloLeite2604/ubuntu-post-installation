#!/bin/bash

# Include guard
[ -n "$_FILE_SH" ] && return || readonly _FILE_SH=1;

create_file_if_does_not_exist() {
  local readonly path="$1";
  local readonly directory=$(dirname $1);

  if [[ -d "$path" ]]; then
    log_error "Path \"$path\" refers to a directory.";
    return $FAILURE;
  fi;

  if [[ ! -f "$path" ]]; then
    create_directory_if_does_not_exist "$directory";
    log_debug "File \"$path\" does not exist. It will be created.";
    touch "$path";
  fi;

}

create_directory_if_does_not_exist() {
  local readonly path="$1";

  if [[ -f "$path" ]]; then
    log_error "Path \"$path\" refers to a file.";
    return $FAILURE;
  fi;

  if [[ ! -d "$path" ]]; then
    log_debug "Directory \"$path\" does not exist. It will be created.";
    mkdir -p "$path";
  fi;

  return $SUCCESS;
}

content_exists_on_file() {
  local readonly content="$1";
  local readonly file="$2";

  if [[ ! -f "$file" ]]; then
    log_error "File \"$file\" does not exist.";
    return $FAILURE;
  fi;

  grep -F "$content" "$file" > /dev/null;
  return;
}

regex_matches_content_on_file() {
  local readonly regex="$1";
  local readonly file="$2";

  if [[ ! -f "$file" ]]; then
    log_error "File \"$file\" does not exist.";
    return $FAILURE;
  fi;

  grep "$regex" "$file" > /dev/null;
  return;
}

backup_file() {
  file_path="$1";
  
  if [[ ! -f "$file_path"  ]]; then
    log_error "File \"$file\" does not exist.";
    return $FAILURE;
  fi;

  date_suffix=$(date +%Y%m%d_%H%M%s);

  backup_file_path="$file_path.$date_suffix.bkp;"

  cp "$file_path" "$backup_file_path";
  return;
}