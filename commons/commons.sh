#!/bin/bash

# Include guard
[ -n "$_COMMONS_SH" ] && return || readonly _COMMONS_SH=1;

DIRECTORY=$(dirname $BASH_SOURCE)/;

source ${DIRECTORY}stage.sh;
source ${DIRECTORY}constants.sh;
source ${DIRECTORY}log.sh;
source ${DIRECTORY}file.sh;
source ${DIRECTORY}properties.sh;

unset DIRECTORY;

retrieve_task_name() {
    path=$1;
    file_name=$(basename $path);

    echo "${file_name%.*}";
}

check_apt_package_is_installed() {
    local package_name=$1;

    dpkg -l $package_name >> /dev/null;
    return;
}

check_any_package_installed_with_pattern() {
    local pattern=$1;
    dpkg-query -f '${Package}\n' -W | grep $pattern >> /dev/null;
    return
}

check_snap_package_is_installed() {
    local package_name=$1;

    snap list | grep ^$package_name >> /dev/null;
    return;
}