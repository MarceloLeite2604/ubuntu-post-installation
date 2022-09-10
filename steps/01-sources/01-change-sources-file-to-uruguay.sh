#!/bin/bash

_description="Changing APT sources to Uruguay."

function _set_up() {
  sources_file_path=/etc/apt/sources.list
}

function _check_step_is_necessary() {
  return 0
}

function _tear_down() {
  unset source_file_path
}

function _execute() {
  cp $sources_file_path $sources_file_path.bkp
  sed -i 's/br./uy./g' $sources_file_path
}
