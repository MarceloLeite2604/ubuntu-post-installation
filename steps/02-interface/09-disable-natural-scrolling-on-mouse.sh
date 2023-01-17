#!/bin/bash

_description="Disable natural scrolling on mouse"

schema="org.gnome.desktop.peripherals.mouse"
key="natural-scroll"
value="false"

function _check_step_is_necessary() {
  _check_gsettings_key "$schema" "$key" "$value"
}

function _execute(){
  _set_gsettings_key "$schema" "$key" "$value"
}