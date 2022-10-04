#!/bin/bash

_description="Set vim as git text editor"

function _check_step_is_necessary() {
  git config --global --get core.editor | grep vim >> /dev/null
  return $?;
}

function _execute() {
  git config --global core.editor "vim"
}