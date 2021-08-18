#!/bin/bash

# Include guard
[ -n "$_LOG_SH" ] && return || readonly _LOG_SH=1;

BLACK_FOREGROUND=`tput setaf 0`;
RED_FOREGROUND=`tput setaf 1`;
GREEN_FOREGROUND=`tput setaf 2`;
YELLOW_FOREGROUND=`tput setaf 3`;
BLUE_FOREGROUND=`tput setaf 4`;
MAGENTA_FOREGROUND=`tput setaf 5`;
CYAN_FOREGROUND=`tput setaf 6`;
WHITE_FOREGROUND=`tput setaf 7`;

BLACK_BACKGROUND=`tput setab 0`;
RED_BACKGROUND=`tput setab 1`;
GREEN_BACKGROUND=`tput setab 2`;
YELLOW_BACKGROUND=`tput setab 3`;
BLUE_BACKGROUND=`tput setab 4`;
MAGENTA_BACKGROUND=`tput setab 5`;
CYAN_BACKGROUND=`tput setab 6`;
WHITE_BACKGROUND=`tput setab 7`;
RESET_LAYOUT=`tput sgr0`;

DEBUG_PREFIX="$MAGENTA_FOREGROUND[DEBUG]:$RESET_LAYOUT";
INFO_PREFIX="$GREEN_FOREGROUND[INFO ]:$RESET_LAYOUT";
WARNING_PREFIX="$YELLOW_FOREGROUND[WARN ]:$RESET_LAYOUT";
ERROR_PREFIX="$RED_FOREGROUND[ERROR]:$RESET_LAYOUT";

function log_debug() {
    local message=$1;

    echo "$DEBUG_PREFIX $message";
}

function log_info() {
    local message=$1;

    echo "$INFO_PREFIX $message";
}

function log_warn() {
    local message=$1;

    echo "$WARNING_PREFIX $message";
}

function log_error() {
    local message=$1;

    echo "$ERROR_PREFIX $message" >&2;
}