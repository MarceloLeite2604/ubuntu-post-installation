#!/bin/bash

_description="Installing curl."

function _check_step_is_necessary() {
  ! _find_apt_package "curl";
}

function _execute() {
  apt install -y curl;
}
