#!/bin/bash

_description="Disable pager on git"

function _check_step_is_necessary() {
  [[ $(git config --global --get core.pager | grep -c cat) -eq 0 ]]
}

function _execute() {
  git config --global core.pager "cat"
}