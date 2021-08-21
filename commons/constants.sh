#!/bin/bash

# Include guard
[ -n "$_CONSTANTS_SH" ] && return || readonly _CONSTANTS_SH=1;

readonly TASKS_DIRECTORY=${WORKING_DIRECTORY}tasks/;
readonly TASKS_AS_SUPERUSER_DIRECTORY=${TASKS_DIRECTORY}as-superuser/;
readonly TASKS_AS_CURRENT_USER_DIRECTORY=${TASKS_DIRECTORY}as-current-user/;
readonly PROPERTIES_FILE_NAME=properties;
readonly SCRIPT_FILE_NAME=script.sh;
readonly SKIP_CONDITION_FILE_NAME=skip-condition.sh;

# Exit/return codes
readonly SUCCESS=0;
readonly FAILURE=255;
readonly SKIP=254;
readonly PROCEED=0;