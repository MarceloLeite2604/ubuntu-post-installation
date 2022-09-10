#!/bin/bash

readonly _scripts_root=$(dirname $0);

source $_scripts_root/functions.sh;

function _check_skip_execution() {
    _retrieve_history "$script";
    local previous_execution=$?;

    case $previous_execution in
        0)
            echo "[$script] Skipped (previously executed)";
            return 1;
        ;;
        1)
            echo "[$script] Retrying";
        ;;
        *)
        ;;
    esac
    return 0;
}

function _run_script() {
    local script="$1";

    _check_skip_execution || return 0;

    _clear_context;

    _load "$script" || return 1;

    _check_context || return 1;

    _setUp;

    if _verify; [[ $? -ne 0 ]];
    then
        echo "[$script] Skipped (no changes are necessary)";
        _tearDown;
        return 0;
    fi;

    echo "[$script] $_description";

    _execute;
    local _execution_result=$?;

    _tearDown;

    if [[ $_execution_result -ne 0 ]];
    then
        >&2 echo "[$script] Failed";
        return 1;
    fi;

    if [[ $(type -t _manual_procedures) == function ]];
    then
        local content="$(_manual_procedures)";
        _add_manual_procedures "[$script] $content";
    fi;
        
    echo "[$script] Complete.";
    return 0;
}

function _search_scripts() {
    echo "$(find $_scripts_root -type f -regex ".*/[0-9]+-[A-z0-9-]+\.sh" | sort | xargs echo)";
}

function run() {
    for script in $(_search_scripts);
    do
        _run_script "$script";
        _result=$?;
        _add_history "$script" $_result;
        if [[ _result -ne 0 ]];
        then
            >&2 echo "Cancelling execution.";
            exit 1;
        fi;
    done;

    echo "Execution completed.";
}

if [[ $(id -u) -ne 0 ]];
then
    >&2 echo "This script must be executed by \"root\" user.";
    >&2 echo "Please chage to \"root\" or execute this script through \"sudo\" command.";
    exit 1;
fi;

run;