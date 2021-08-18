#!/bin/bash

# Include guard
[ -n "$_CONSTANTS_SH" ] && return || readonly _CONSTANTS_SH=1;

# Exit/return codes
SUCCESS=0
FAILURE=255
SKIP=254