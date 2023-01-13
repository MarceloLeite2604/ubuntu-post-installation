#!/bin/bash

_description="Installing IntelliJ Idea Community Edition."

function _check_step_is_necessary() {
  ! _find_snap_package "intellij-idea-community"
}

function _execute() {
  snap install intellij-idea-community --classic;
}
