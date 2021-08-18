#!/bin/bash

# Include guard
if [ -z "$COMMONS_SH" ];
then
    COMMONS_SH=1;
else
    return;
fi;

DIRECTORY=$(dirname $BASH_SOURCE)/;

source ${DIRECTORY}stage.sh;
source ${DIRECTORY}constants.sh;
source ${DIRECTORY}log.sh;
source ${DIRECTORY}file.sh;
source ${DIRECTORY}properties.sh;

unset DIRECTORY;

function retrieve_task_name() {
    path=$1;
    file_name=$(basename $path);

    echo "${file_name%.*}";
}