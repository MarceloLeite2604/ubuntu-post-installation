#!/bin/bash

_description="Installing Bitwarden."

function _check_step_is_necessary() {
  ! _find_snap_package "bitwarden"
}

function _execute() {
  snap install bitwarden;
}