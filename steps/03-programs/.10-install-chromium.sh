#!/bin/bash

_description="Install Spotify."

function _check_step_is_necessary() {
  snap list chromium >> /dev/null
  return $?;
}

function _execute() {
  snap install chromium
}