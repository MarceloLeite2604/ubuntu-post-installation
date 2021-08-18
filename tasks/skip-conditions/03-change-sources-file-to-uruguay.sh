#!/bin/bash

source $(dirname $BASH_SOURCE)/../../commons/commons.sh

SOURCES_FILE_PATH=/etc/apt/sources.list;

content_exists_on_file "//uy." $SOURCES_FILE_PATH && exit $SKIPPED;