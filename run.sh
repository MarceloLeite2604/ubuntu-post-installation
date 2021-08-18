#!/bin/bash

WORKING_DIRECTORY=$(dirname $BASH_SOURCE)/;
EXECUTIONS_DIRECTORY=$(dirname $BASH_SOURCE)/tasks/executions/;
SKIP_CONDITIONS_DIRECTORY=$(dirname $BASH_SOURCE)/tasks/skip-conditions/;

source $WORKING_DIRECTORY/commons/commons.sh;

create_stage;

check_skip_script_exists() {
    local file_name=$1;
    [[ -f $SKIP_CONDITIONS_DIRECTORY$file_name ]];
    return;
}

save_properties() {
    local execution_path=$1;
    local file_name=${execution_path##*/};
    local execution_name=${file_name%.*};

    save_property "file_name" $file_name;
    save_property "execution_name" $execution_name;
}

for execution_path in $EXECUTIONS_DIRECTORY*; do
    clear_properties;
    save_properties $execution_path;
    file_name=$(load_property "file_name");
    execution_name=$(load_property "execution_name");
    log_debug "Analysing execution \"$execution_name\".";

    if check_skip_script_exists $file_name; then
        log_debug "Skip script \"$file_name\" will be executed.";
        $SKIP_CONDITIONS_DIRECTORY$file_name;
        check_result=$?;
        skip=false; [[ $check_result -eq $SKIP ]] && skip=true;
    else
        log_debug "No skip script found for $execution_name.";
        skip=false;
    fi;

    if [[ ! $skip ]]; then
        log_info "Execution \"$execution_name\" will be skipped.";
        continue;
    fi;

    log_info "Execution \"$execution_name\" will be done.";
    $EXECUTIONS_DIRECTORY$file_name;
done;

delete_stage;