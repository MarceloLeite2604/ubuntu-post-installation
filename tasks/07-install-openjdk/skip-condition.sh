#!/bin/bash

source $(dirname $BASH_SOURCE)/../../commons/commons.sh

check_any_package_installed_with_pattern "openjdk-.*-jdk" && exit $SKIP;