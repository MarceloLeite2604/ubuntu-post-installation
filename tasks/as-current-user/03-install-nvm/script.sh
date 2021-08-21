#!/bin/bash

source $(dirname $BASH_SOURCE)/../../../commons/commons.sh

readonly NVM_VERSION="v0.38.0"

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/$NVM_VERSION/install.sh | bash;

if [[ $? -ne 0 ]]; then
  log_error "Error while installing nvm.";
  exit $FAILURE;
fi;

log_info "nvm $NVM_VERSION installed.";