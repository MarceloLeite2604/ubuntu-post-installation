#!/bin/bash

# Add your script description on this constant.
_description="Install Yarn"

# Create a logic to verify if it is necessary to execute the scirpt.
function _check_step_is_necessary() {
  return 0
}

# Create the logic to implement the proper system modifications here.
function _execute() {

  if [[ -z "$NVM_DIR" || ! -s "$NVM_DIR/nvm.sh" ]]; then
    >&2 echo "nvm tool is not installed. Please install nvm before attempting to install Node."
    return 1;
  fi;

  # shellcheck source=/dev/null
  source "$NVM_DIR/nvm.sh";

  if ! _find_binary "node"; then
    >&2 echo "Could not find node binary. Make sure Node is installed."
    return 1;
  fi;

  if ! _find_binary "corepack"; then
    >&2 echo "Node corepack binary is not installed. Make sure that you have installed node version 16.10 or greater to install Yarn."
    return 1;
  fi;

  corepack enable;
  corepack prepare yarn@stable --activate
}
