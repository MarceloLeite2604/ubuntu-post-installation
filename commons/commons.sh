#!/bin/bash

# Include guard
[ -n "$_COMMONS_SH" ] && return || readonly _COMMONS_SH=1;

DIRECTORY=$(dirname $BASH_SOURCE)/;

source ${DIRECTORY}stage.sh;
source ${DIRECTORY}constants.sh;
source ${DIRECTORY}log.sh;
source ${DIRECTORY}file.sh;
source ${DIRECTORY}properties.sh;
source ${DIRECTORY}apt.sh;
source ${DIRECTORY}snap.sh;

unset DIRECTORY;

retrieve_task_name() {
  local readonly path=$1;
  local readonly file_name=${path##*/};
  echo "${file_name%.*}";
}