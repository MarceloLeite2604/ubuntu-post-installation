#!/bin/bash

_description="Change mouse click emulation"

schema="org.gnome.desktop.peripherals.touchpad"
key="click-method"
value="fingers"

function _check_step_is_necessary() {
  _check_gsettings_key "$schema" "$key" "$value"
}

function _execute(){
  _set_gsettings_key "$schema" "$key" "$value"
}