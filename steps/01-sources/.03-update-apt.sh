#!/bin/bash

_description="Updating apt."

function _check_step_is_necessary() {
  return 0;
}

function _execute() {
  apt update;
}
