#!/bin/bash

_description="Enable switcher to select windows on all workspaces"

schema="org.gnome.shell.window-switcher"
key="current-workspace-only"
value="false"

function _check_step_is_necessary() {
  _check_gsettings_key "$schema" "$key" "$value"
}

function _execute(){
  _set_gsettings_key "$schema" "$key" "$value"
}