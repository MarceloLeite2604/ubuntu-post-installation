#!/bin/bash

source $(dirname $BASH_SOURCE)/../../../commons/commons.sh

backup_file $SOURCES_FILE_PATH;
sed -i 's/br./uy./g' $SOURCES_FILE_PATH;

log_info "Apt sources server changed to Uruguay."