#!/bin/bash

_description="Change Snap refresh interval."

refresh_value="wed2,wed4";

function _check_step_is_necessary() {
  [[ $(snap get system refresh.timer 2>/dev/null | grep -c "$refresh_value") -eq 0 ]]; 
}

function _execute() {
  snap set system refresh.timer=wed2,wed4
}