#!/bin/bash

source $(dirname $BASH_SOURCE)/../../../commons/commons.sh

check_apt_package_is_installed curl && exit $SKIP;
