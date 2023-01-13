#!/bin/bash

_description="Installing Spotify."

function _check_step_is_necessary() {
  ! _find_snap_package "spotify"
}

function _execute() {
  snap install spotify
}