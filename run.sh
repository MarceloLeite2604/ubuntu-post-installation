#!/bin/bash

getopts "d" _DEBUG;
[[ "$_DEBUG" == "d" ]] && _DEBUG=0 || _DEBUG=1;

readonly WORKING_DIRECTORY=$(dirname $BASH_SOURCE)/;

source $WORKING_DIRECTORY/commons/commons.sh;

if [[ "$(whoami)" != "root" ]]; then
  log_error "This script must be executed as root."
  log_error "Either log in as root or run this script with \"sudo\"."
  exit $FAILURE;
fi;

load_task_properties() {
  local readonly task=$1;
  local readonly properties_file="$TASKS_DIRECTORY$task/$PROPERTIES_FILE_NAME";

  if [[ -f "$properties_file" ]]; then
  log_debug "Loading properties for task \"$task\".";
    load_properties $properties_file;
  fi;
}

unload_task_properties() {
  local readonly task=$1;
  local readonly properties_file="$TASKS_DIRECTORY$task/$PROPERTIES_FILE_NAME";

  if [[ -f "$properties_file" ]]; then
    unload_properties $properties_file;
  fi;
}

check_skip_condition() {
  local readonly task=$1;
  local readonly skip_script="$TASKS_DIRECTORY$task/$SKIP_CONDITION_FILE_NAME";

  if [[ -f "$skip_script" ]]; then
    log_debug "Executing skip condition script for task \"$task\".";
    $skip_script;
    return;
  fi;

  log_debug "No skip condition script found for task \"$task\".";
  return $PROCEED;
}

for task_directory in $TASKS_DIRECTORY*; do
    
  task=${task_directory##*/};
  log_debug "Analysing task \"$task\".";

  load_task_properties $task;

  task_directory="$TASKS_DIRECTORY$task/";
  
  check_skip_condition $task;
  skip=$?;
  
  if [[ $skip -eq $SKIP ]]; then
    log_info "Task \"$task\" will be skipped.";
    continue;
  fi;

  log_info "Task \"$task\" will be executed.";
  $task_directory$SCRIPT_FILE_NAME;

  unload_task_properties $task;
done;