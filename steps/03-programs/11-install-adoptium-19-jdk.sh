#!/bin/bash

set -e

_description="Installing Adoptium 19.0.1+10 JDK."

file_name="OpenJDK19U-jdk_x64_linux_hotspot_19.0.1_10.tar.gz";
readonly file_name;

jdk_download_url="https://github.com/adoptium/temurin19-binaries/releases/download/jdk-19.0.1%2B10/$file_name";
readonly jdk_download_url;

installation_directory="/opt/eclipse/adoptium";
readonly installation_directory;

function _check_step_is_necessary() {
  ! ls "$installation_directory" >/dev/null 2>&1;
}

function _execute() {
  if ! _find_binary "curl"; then
    _log "Could not find \"curl\" program." "ERROR"
    return 1;
  fi;

  if ! _find_binary "tar"; then
    _log "Could not find \"tar\" program." "ERROR"
    return 1;
  fi;

  # shellcheck disable=SC2154
  curl -L "$jdk_download_url" --output "$_cache_directory/$file_name"
  if [[ ! -f "$_cache_directory/$file_name" ]]; then
    _log "Something went wrong while downloading file." "ERROR"
    return 1;
  fi;

  mkdir -p "$installation_directory"

  # shellcheck disable=SC2154
  tar -xzvf "$_cache_directory/$file_name" -C "$installation_directory"

  chown -R "$SUDO_UID":"$SUDO_GID" "$installation_directory"

  local java_bin_directory_suffix;
  # shellcheck disable=SC2154
  java_bin_directory_suffix=$(tar -tf "$_cache_directory/$file_name" | grep "java$" | xargs dirname);
  readonly java_bin_directory_suffix;
  if [[ -z "$java_bin_directory_suffix" ]]; then
    _log "Could not find \"java\" binary directory on installation path.";
  fi;

  local installation_directory_suffix;
  # shellcheck disable=SC2154 
  installation_directory_suffix=$(tar -tf "$_cache_directory/$file_name" | sort | head -n 1);
  installation_directory_suffix=${installation_directory_suffix%/};
  readonly installation_directory_suffix
  if [[ -z "$installation_directory_suffix" ]]; then
    _log "Could not find installation directory suffix.";
  fi;

  local java_home="$installation_directory/$installation_directory_suffix";
  readonly java_home;

  local java_bin_path="$installation_directory/$java_bin_directory_suffix";
  readonly java_bin_path;

  printf "\nexport JAVA_HOME=\"%s\"\n" "$java_home" >> "/home/$SUDO_USER/.bashrc";
  printf "\nexport PATH=\"\$PATH:%s\"\n" "$java_bin_path" >> "/home/$SUDO_USER/.bashrc";
}

function _manual_procedures() {
  cat <<EOF
To use Java on command line, either terminate all opened terminal sessions or use ". ~/.bashrc" command to create JAVA_HOME and update PATH environment variables.
EOF
}