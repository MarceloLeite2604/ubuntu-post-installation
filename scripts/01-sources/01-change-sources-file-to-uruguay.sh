#!/bin/bash

_description="Changing APT sources to Uruguay."

function _setUp() {
  sources_file_path=/etc/apt/sources.list
}

function _verify() {
  return 0
}

function _tearDown() {
  unset source_file_path
}

function _execute() {
  cp $sources_file_path $sources_file_path.bkp
  sed -i 's/br./uy./g' $sources_file_path
}
