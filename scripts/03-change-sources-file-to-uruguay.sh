#!/bin/bash

source $(dirname $BASH_SOURCE)/../commons/commons.sh
task=$(retrieve_task_name $0);

SOURCES_FILE_PATH=/etc/apt/sources.list;

# Skip condition
log_debug "Checking skip condition for task \"$task\".";
if content_exists_on_file "//uy." $SOURCES_FILE_PATH; then
	log_info "Skipping task \"$task\" execution.";
	exit $SKIPPED;
fi;
log_debug "Skip condition was not fullfilled. Executing job.";

backup_file $SOURCES_FILE_PATH;
sed -i 's/br./uy./g' $SOURCES_FILE_PATH;

log_info "Apt sources server changed to Uruguay."