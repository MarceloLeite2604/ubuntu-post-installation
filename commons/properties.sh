#!/bin/bash

# Include guard
[ -n "$_PROPERTIES_SH" ] && return || readonly _PROPERTIES_SH=1;

DIRECTORY=$(dirname $BASH_SOURCE)/;

source ${DIRECTORY}log.sh
source ${DIRECTORY}file.sh

TASK_PROPERTY_NAME="task";

check_property_exists() {
    local name=$1;

    local property_regex="^$name=.*";

    grep $property_regex $PROPERTIES_FILE_PATH >> /dev/null;
    return;
}

save_property() {
    local name=$1;
    local value=$2;

    if check_property_exists $name; then
        delete_property $name;
    fi;

    echo "$name=$value" >> $PROPERTIES_FILE_PATH;
}

load_property() {
    local name=$1;

    local property_regex="^$name=\(.*\)\n";

    if ! check_property_exists $name; then
        log_error "Property \"$name\" not found.";
        exit $FAILURE;
    fi;

    echo $(sed -n "s/$name=\(\S\+\)/\1/p" $PROPERTIES_FILE_PATH);
}

delete_property() {
    local name=$1;
    sed -i "/^$name=.*/d" $PROPERTIES_FILE_PATH;
}

clear_properties() {
    truncate -s 0 $PROPERTIES_FILE_PATH;
}