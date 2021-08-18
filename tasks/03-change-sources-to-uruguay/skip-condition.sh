#!/bin/bash

source $(dirname $BASH_SOURCE)/../../commons/commons.sh

content_exists_on_file "//uy." $SOURCES_FILE_PATH && exit $SKIPPED;