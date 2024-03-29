#!/bin/bash

_description="Show weekday on calendar"

schema="org.gnome.desktop.interface"
key="clock-show-weekday"
value="true"

function _check_step_is_necessary() {
  _check_gsettings_key "$schema" "$key" "$value"
}

function _execute(){
  _set_gsettings_key "$schema" "$key" "$value"
}
