#!/bin/bash

WORKING_DIRECTORY=$(dirname $BASH_SOURCE)/;

source ${WORKING_DIRECTORY}/commons/commons.sh;

create_stage;
delete_stage;