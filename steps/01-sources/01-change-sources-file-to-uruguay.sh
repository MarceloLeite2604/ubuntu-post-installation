#!/bin/bash

_description="Changing APT sources to Uruguay."

sources_file_path=/etc/apt/sources.list

function _check_step_is_necessary() {
  [[ $(grep -c "http://uy" "$sources_file_path") -eq 0 ]];
}

function _execute() {
  cp $sources_file_path $sources_file_path.bkp
  sed -i 's/br./uy./g' $sources_file_path
}
