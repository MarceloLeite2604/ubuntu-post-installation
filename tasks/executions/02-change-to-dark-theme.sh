#!/bin/bash

source $(dirname $BASH_SOURCE)/../commons/commons.sh
task=$(retrieve_task_name $0);

DARK_THEME="'Adwaita-dark'";

# Skip condition
log_debug "Checking skip condition for task \"$task\".";
if [[ $(gsettings get org.gnome.desktop.interface gtk-theme) == $DARK_THEME ]]; then
	log_info "Skipping task \"$task\" execution.";
	exit $SKIPPED;
fi;
log_debug "Skip condition was not fullfilled. Executing job.";

gsettings set org.gnome.desktop.interface gtk-theme $DARK_THEME;

log_info "GTK Theme replaced";