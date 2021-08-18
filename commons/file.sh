#!/bin/bash

# Include guard
if [[ -z "$_FILE_SH" ]]; then
    _FILE_SH=1;
else
    return;
fi;

function create_file_if_does_not_exist() {
    local path=$1;
    local directory=$(dirname $1);

    if [[ -d $path ]]; then
        log_error "Path \"$path\" refers to a directory.";
        return $FAILURE;
    fi;

    if [[ ! -f $path ]]; then
        create_directory_if_does_not_exist $directory;
        log_debug "File \"$path\" does not exist. It will be created.";
        touch $path;
    fi;

}

function create_directory_if_does_not_exist() {
    local path=$1;

    if [[ -f $path ]]; then
        log_error "Path \"$path\" refers to a file.";
        return $FAILURE;
    fi;

    if [[ ! -d $path ]]; then
        log_debug "Directory \"$path\" does not exist. It will be created.";
        mkdir -p $path;
    fi;

    return $SUCCESS;
}

function content_exists_on_file() {
    content=$1;
    file=$2;

    if [[ ! -f $file ]]; then
        log_error "File \"$file\" does not exist.";
        return $FAILURE;
    fi;

    grep -F $content $file > /dev/null;
    return;
}

function regex_matches_content_on_file() {
    regex=$1;
    file=$2;

    if [[ ! -f $file ]]; then
        log_error "File \"$file\" does not exist.";
        return $FAILURE;
    fi;

    grep $regex $file > /dev/null;
    return;
}

function backup_file() {
    file_path=$1;
    index=$2;
    
    if [[ ! -f $file_path  ]]; then
        log_error "File \"$file\" does not exist.";
        return $FAILURE;
    fi;

    date_suffix=$(date +%Y%m%d_%H%M%s);

    backup_file_path=$file_path.$date_suffix.bkp;

    cp $file_path $backup_file_path;
    return;
}