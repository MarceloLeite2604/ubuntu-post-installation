#!/bin/bash

source $(dirname $BASH_SOURCE)/../../commons/commons.sh

readonly MIN_SECONDS_SINCE_LAST_UPDATE=3600;
readonly APT_CACHE_FILE_PATH="/var/cache/apt/pkgcache.bin";

[[ ! -f $APT_CACHE_FILE_PATH ]] && exit $PROCEED;

last_update=$(stat -c '%Y' $APT_CACHE_FILE_PATH);
now=$(date +%s);
seconds_since_last_update=$(($now - $last_update));

[[ $seconds_since_last_update -le $MIN_SECONDS_SINCE_LAST_UPDATE ]] && exit $SKIP;