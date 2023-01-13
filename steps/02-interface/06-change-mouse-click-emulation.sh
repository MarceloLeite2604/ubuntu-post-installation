#!/bin/bash

_description="Change mouse click emulation"

schema="org.gnome.desktop.peripherals.touchpad"
key="click-method"
value="fingers"

function _check_step_is_necessary() {
  [[ $(gsettings get "$schema" "$key" 2>/dev/null | grep -c "$value") -eq 0 ]];
}

function _execute(){
  sudo -E -u "$SUDO_USER" DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$SUDO_UID/bus" gsettings set "$schema" "$key" "$value";
}