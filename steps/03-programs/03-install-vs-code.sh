#!/bin/bash

_description="Installing Visual Studio Code."

function _check_step_is_necessary() {
  ! _find_snap_package "code";
}

function _execute() {
  snap install --classic code;
}
