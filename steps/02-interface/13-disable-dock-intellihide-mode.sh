#!/bin/bash

_description="Hide Dock Intellihide mode"

schema="org.gnome.shell.extensions.dash-to-dock"
key="intellihide"
value="false"

function _check_step_is_necessary() {
  _check_gsettings_key "$schema" "$key" "$value"
}

function _execute(){
  _set_gsettings_key "$schema" "$key" "$value"
}