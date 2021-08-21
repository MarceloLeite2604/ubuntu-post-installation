#!/bin/bash

# Include guard
[ -n "$_COMMONS_SH" ] && return || readonly _COMMONS_SH=1;

getopts "d" _DEBUG;
[[ "$_DEBUG" == "d" ]] && _DEBUG=0 || _DEBUG=1;


DIRECTORY=$(dirname $BASH_SOURCE)/;

source ${DIRECTORY}stage.sh;
source ${DIRECTORY}constants.sh;
source ${DIRECTORY}log.sh;
source ${DIRECTORY}file.sh;
source ${DIRECTORY}properties.sh;
source ${DIRECTORY}apt.sh;
source ${DIRECTORY}snap.sh;

unset DIRECTORY;

load_task_properties() {
  local readonly directory="$1";
  local readonly task="$2";
  local readonly properties_file="$directory$task/$PROPERTIES_FILE_NAME";

  if [[ -f "$properties_file" ]]; then
  log_debug "Loading properties for task \"$task\".";
    load_properties $properties_file;
  fi;
}

unload_task_properties() {
  local readonly directory="$1";
  local readonly task="$2";
  local readonly properties_file="$directory$task/$PROPERTIES_FILE_NAME";

  if [[ -f "$properties_file" ]]; then
    unload_properties $properties_file;
  fi;
}

check_skip_condition() {
  local readonly directory="$1";
  local readonly task="$2";
  local readonly skip_script="$directory$task/$SKIP_CONDITION_FILE_NAME";

  if [[ -f "$skip_script" ]]; then
    log_debug "Executing skip condition script for task \"$task\".";
    $skip_script;
    return;
  fi;

  log_debug "No skip condition script found for task \"$task\".";
  return $PROCEED;
}

run_tasks_on_directory() {
  local readonly directory="$1";
  for task_directory in $directory*; do
    
    task=${task_directory##*/};
    log_debug "Analysing task \"$task\".";

    load_task_properties "$directory" "$task";

    task_directory="$directory$task/";
    
    check_skip_condition "$directory" "$task";
    skip=$?;
    
    if [[ $skip -eq $SKIP ]]; then
      log_info "Task \"$task\" will be skipped.";
      continue;
    fi;

    log_info "Task \"$task\" will be executed.";
    $task_directory$SCRIPT_FILE_NAME;

    unload_task_properties $task;
  done;
}