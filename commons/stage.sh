#!/bin/bash

# Include guard
if [[ -z "$_STAGE_SH" ]]; then
    _STAGE_SH=1;
else
    return;
fi;

STAGE_DIRECTORY_PATH=$WORKING_DIRECTORY".stage/";
PROPERTIES_FILE_PATH=${STAGE_DIRECTORY_PATH}properties;

create_stage() {
    create_directory_if_does_not_exist $STAGE_DIRECTORY_PATH;
    create_file_if_does_not_exist $PROPERTIES_FILE_PATH;
}

delete_stage() {
    echo "rm -rf $STAGE_DIRECTORY_PATH";
}