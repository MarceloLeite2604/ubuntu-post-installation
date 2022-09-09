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

    if [[ _verify -ne 0 ]];
    then
        return 0;
    fi;

    echo "[$script] $_description";
    _execute;
    local _execution_result=$?;

    if [[ $_execution_result -ne 0 ]];
    then
        >&2 echo "[$script] Failed";
        return 1;
    fi;
        
    echo "[$script] Complete.";
    return 0;
}

_run_script "$_scripts_root/dummy.sh";
_result=$?;
_add_history "$_scripts_root/dummy.sh" $_result;