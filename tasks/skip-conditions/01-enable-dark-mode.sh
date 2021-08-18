#!/bin/bash

source $(dirname $BASH_SOURCE)/../../commons/commons.sh

CONFIGURATION_FILE_PATH=~/.config/gtk-4.0/settings.ini;
CONFIGURATION_TEXT="gtk-application-prefer-dark-theme=1";

[[ -f $CONFIGURATION_FILE_PATH ]] && 
content_exists_on_file $CONFIGURATION_TEXT $CONFIGURATION_FILE_PATH && 
exit $SKIP;