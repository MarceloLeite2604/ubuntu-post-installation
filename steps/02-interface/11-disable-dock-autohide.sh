#!/bin/bash

_description="Disable Dock autohide mode"

schema="org.gnome.shell.extensions.dash-to-dock"
key="autohide"
value="false"

function _check_step_is_necessary() {
  _check_gsettings_key "$schema" "$key" "$value"
}

function _execute(){
  _set_gsettings_key "$schema" "$key" "$value"
}