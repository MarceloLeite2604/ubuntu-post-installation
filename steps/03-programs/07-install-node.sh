#!/bin/bash

# Add your script description on this constant.
_description="Install Node"

# Create a logic to verify if it is necessary to execute the scirpt.
function _check_step_is_necessary() {

  if [[ -z "$NVM_DIR" || ! -s "$NVM_DIR/nvm.sh" ]]; then
    return 1;
  fi;

  # shellcheck source=/dev/null
  source "$NVM_DIR/nvm.sh";

  ! _find_binary "node";
}

# Create the logic to implement the proper system modifications here.
function _execute() {
  if [[ -z "$NVM_DIR" || ! -s "$NVM_DIR/nvm.sh" ]]; then
    >&2 echo "nvm tool is not installed. Please install nvm before attempting to install Node."
    return 1;
  fi;

  # shellcheck source=/dev/null
  source "$NVM_DIR/nvm.sh";

  local do=true;
  local version;
  while $do || [[ -n "$version" && "$(nvm ls-remote | grep -c "$version")" -ne 1 ]]; do
    if ! $do; then
      # shellcheck disable=SC2154
      _log "Invalid version value." "$_log_level_error"
      sleep 2;
    fi;
    do=false;

    echo "The following versions are available for installation"
    nvm ls-remote;
    read -rp "Which Node version do you want to install [latest LTS]? " version && printf "\n";
  done

  if [[ -z "$version" ]]; then 
    version="--lts";
  fi;
  
  sudo -Eu "$SUDO_USER" bash -c "source \"$NVM_DIR/nvm.sh\"; nvm install \"$version\";nvm use default";

  # Force bashrc reloading.
  printf "\n" >> ~/.bashrc
}