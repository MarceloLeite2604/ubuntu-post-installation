#!/bin/bash

_description="Install Bitwarden."

function _check_step_is_necessary() {
  snap list bitwarden >> /dev/null
  return $?;
}

function _execute() {
  snap install bitwarden
}