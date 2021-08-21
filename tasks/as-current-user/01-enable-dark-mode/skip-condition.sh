#!/bin/bash

source $(dirname $BASH_SOURCE)/../../../commons/commons.sh

[[ -f $CONFIGURATION_FILE_PATH ]] && 
content_exists_on_file $CONFIGURATION_TEXT $CONFIGURATION_FILE_PATH && 
exit $SKIP;