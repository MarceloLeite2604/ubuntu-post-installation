#!/bin/bash

_description="Installing Chromium."

function _check_step_is_necessary() {
  ! _find_snap_package "chromium"
}

function _execute() {
  snap install chromium
}