#!/bin/bash

# Add your script description on this constant.
_description="Install Powerline fonts"

# Create a logic to verify if it is necessary to execute the scirpt.
function _check_step_is_necessary() {
  ! _find_apt_package "fonts-powerline"
}

# Create the logic to implement the proper system modifications here.
function _execute() {
  apt install -y fonts-powerline;
}

# Add here additional procedures that must be done manually by the user.
# This function can be deleted if there are no additional procedures.
function _manual_procedures() {
  echo -n "Open your Terminal settings and select a Powerline font for current profile."
}