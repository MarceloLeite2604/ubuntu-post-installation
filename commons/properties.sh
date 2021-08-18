#!/bin/bash

# Include guard
if [[ -z "$PROPERTIES_SH" ]]; then
    PROPERTIES_SH=1;
else
    return;
fi;

DIRECTORY=$(dirname $BASH_SOURCE)/;

source ${DIRECTORY}log.sh
source ${DIRECTORY}file.sh

PROPERTIES_FILE_PATH=${STAGE_DIRECTORY_PATH}properties;
TASK_PROPERTY_NAME="task";

check_property_exists() {
    local name=$1;

    local property_regex="^$name=.*\n";

    grep $property_regex $PROPERTIES_FILE_PATH;
    return;
}

save_property() {
    local name=$1;
    local value=$2;

    if check_property_exists $name; then
        delete_property $name;
    fi;

    echo $name=$value >> $PROPERTIES_FILES_PATH;
}

load_property() {
    local name=$1;

    local property_regex="^$name=\(.*\)\n";

    if ! check_property_exists $name; then
        log_error "Property \"$name\" not found.";
        exit $FAILURE;
    fi;

    echo $(sed -n "s/$name=\(\S\+\)/\1/p" $PROPERTIES_FILES_PATH);
}

delete_property() {
    local name=$1;
    sed -i "s/^$name=.*\n//" $PROPERTIES_FILES_PATH;
}