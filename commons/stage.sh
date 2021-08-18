#!/bin/bash

# Include guard
if [[ -z "$STAGE_SH" ]]; then
    STAGE_SH=1;
else
    return;
fi;

STAGE_DIRECTORY_PATH=$WORKING_DIRECTORY".stage/";

create_stage() {
    create_directory_if_does_not_exist $STAGE_DIRECTORY_PATH;
}

delete_stage() {
    echo "rm -rf $STAGE_DIRECTORY_PATH";
}