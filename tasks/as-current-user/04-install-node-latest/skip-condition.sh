#!/bin/bash

source $(dirname $BASH_SOURCE)/../../../commons/commons.sh

nvm use latest &>/dev/null;
[[  $? -eq 0 ]] && exit $SKIP;