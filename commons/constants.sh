#!/bin/bash

# Include guard
if [[ -z "$CONSTANTS_SH" ]]; then
    CONSTANTS_SH=1;
else
    return;
fi;

# Exit/return codes
SUCCESS=0
FAILURE=255
SKIP=254