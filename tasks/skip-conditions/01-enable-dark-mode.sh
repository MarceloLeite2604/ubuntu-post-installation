#!/bin/bash

source $(dirname $BASH_SOURCE)/../commons/commons.sh
task=$(retrieve_task_name $0);

CONFIGURATION_FILE_PATH=~/.config/gtk-4.0/settings.ini;
CONFIGURATION_TEXT="gtk-application-prefer-dark-theme=1";

# Skip condition
log_debug "Checking skip condition for task \"$task\".";
if [[ -f $CONFIGURATION_FILE_PATH ]] && content_exists_on_file $CONFIGURATION_TEXT $CONFIGURATION_FILE_PATH; then
	log_info "Skipping task \"$task\" execution.";
	exit $SKIP;
fi;
exit $PROCEED;