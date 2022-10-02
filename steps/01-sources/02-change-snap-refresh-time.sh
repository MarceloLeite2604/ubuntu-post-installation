#!/bin/bash

_description="Change Snap refresh interval."

refresh_value="wed2,wed4";

function _check_step_is_necessary() {
  snap get system refresh.timer | grep "$refresh_value" >> /dev/null
  return $?;
}

function _execute() {
  snap set system refresh.timer=wed2,wed4
}