#!/bin/bash

_description="Change window bar button location"

schema="org.gnome.desktop.wm.preferences"
key="button-layout"
value="close,minimize,maximize:"

function _check_step_is_necessary() {
  _check_gsettings_key "$schema" "$key" "$value"
}

function _execute(){
  _set_gsettings_key "$schema" "$key" "$value"
}