#!/bin/bash

source $(dirname $BASH_SOURCE)/../../../commons/commons.sh

check_snap_package_is_installed code && exit $SKIP;
