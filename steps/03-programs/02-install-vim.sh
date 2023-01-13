#!/bin/bash

_description="Installing vim."

function _check_step_is_necessary() {
  ! _find_apt_package "vim";
}

function _execute() {
  apt install -y vim;
}
