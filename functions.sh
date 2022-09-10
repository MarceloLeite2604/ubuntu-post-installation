#!/bin/bash

if [[ -n "$_FUNCTIONS_SH" ]];
then
    return;
fi;
_FUNCTIONS_SH=1;

if [[ -z "$_scripts_root" ]];
then
    readonly _scripts_root=$(dirname $0);
fi;

if [[ -z "$_temporary_directory" ]];
then
    readonly _temporary_directory="/tmp/ubuntu-post-installation";
fi;

if [[ -z "$_manual_procedures_file_name" ]];
then
    readonly _manual_procedures_file_name="manual-procedures.txt";
fi;

if [[ -z "$_manual_procedures_file_path" ]];
then
    readonly _manual_procedures_file_path="$_temporary_directory/$_manual_procedures_file_name";
fi;

readonly _history_file="$_scripts_root/.history";

function _clear_history() {
    echo -n "" > $_history_file; 
}

function _add_history() {
    local script="$1";
    local result="$2";
    echo "$script $result" >> $_history_file;
}

function _retrieve_history() {
    local script="$1";

    if [[ ! -f $_history_file ]];
    then
        touch $_history_file;
        return -1;
    fi;

    local content=$(cat $_history_file | grep "$script");

    if [ -z "$content" ];
    then
        return -1;
    else
        return ${content##* };
    fi;
}

function _clear_context() {
    unset $_description;
    unset -f _setUp;
    unset -f _verify;
    unset -f _execute;
    unset -f _tearDown;
    unset -f _manual_procedures;
}

function _check_context() {
    if [[ -z "$_description" ]];
    then
        >&2 echo "\"_description\" variable is not set.";
        return 1;
    fi;

    if [[ $(type -t _setUp) != function ]];
    then
        >&2 echo "\"_setUp\" function is not set.";
        return 1;
    fi;

    if [[ $(type -t _verify) != function ]];
    then
        >&2 echo "\"_verify\" function is not set.";
        return 1;
    fi;

    if [[ $(type -t _execute) != function ]];
    then
        >&2 echo "\"_execute\" function is not set.";
        return 1;
    fi;

    if [[ $(type -t _tearDown) != function ]];
    then
        >&2 echo "\"_tearDown\" function is not set.";
        return 1;
    fi;

    return 0;
}

function _load() {
    local script="$1";

    if [[ ! -f "$script" ]];
    then
        >&2 echo "Could not find script \"$script\".";
        return 1;
    fi;

    source $script;
    return 0;
}

function _create_manual_procedures_file() {
    if [[ ! -f "$_manual_procedures_file_path" ]];
    then
        touch "$_manual_procedures_file_path";
    fi;
}

function _clear_manual_procedures_file() {
    create_manual_procedures_file;
    echo -n "" >> "$_manual_procedures_file_path";
}

function _add_manual_procedures() {
    local content="$1";

    echo $content >> "$_manual_procedures_file_name";
}