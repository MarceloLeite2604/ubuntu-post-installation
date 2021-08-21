#!/bin/bash

source $(dirname $BASH_SOURCE)/../../../commons/commons.sh

create_file_if_does_not_exist $CONFIGURATION_FILE_PATH;

cat >> $CONFIGURATION_FILE_PATH << EOF
[Settings]
gtk-application-prefer-dark-theme=1
EOF

log_info "Dark theme enabled on GTK";