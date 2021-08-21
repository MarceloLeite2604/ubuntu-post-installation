#!/bin/bash

source $(dirname $BASH_SOURCE)/../../../commons/commons.sh

nvm install latest;

if [[ $? -ne 0 ]]; then
  log_error "Error while installing latest Node version.";
  exit $FAILURE;
fi;

log_info "Lastest Node version installed.";