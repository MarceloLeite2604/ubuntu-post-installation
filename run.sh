#!/bin/bash

readonly WORKING_DIRECTORY=$(dirname $BASH_SOURCE)/;

source $WORKING_DIRECTORY/commons/commons.sh;

if [[ "$(whoami)" != "root" ]]; then
  log_info "The next tasks are going to be executed as \"root\"."
  log_info "You might be prompted to enter your password."
fi;

sudo -E ${WORKING_DIRECTORY}execute-superuser-tasks.sh;

log_info "The next tasks are going to be executed as \"$USER\"."
${WORKING_DIRECTORY}execute-current-user-tasks.sh;