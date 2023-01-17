#!/bin/bash

_description="Disable natural scrolling on touchpad"

schema="org.gnome.desktop.peripherals.touchpad"
key="natural-scroll"
value="false"

function _check_step_is_necessary() {
  _check_gsettings_key "$schema" "$key" "$value"
}

function _execute(){
  _set_gsettings_key "$schema" "$key" "$value"
}