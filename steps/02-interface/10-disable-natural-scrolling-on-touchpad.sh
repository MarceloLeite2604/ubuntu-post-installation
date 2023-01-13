#!/bin/bash

_description="Disable natural scrolling on touchpad"

schema="org.gnome.desktop.peripherals.touchpad"
key="natural-scroll"
value="false"

function _check_step_is_necessary() {
  [[ $(gsettings get "$schema" "$key" 2>/dev/null | grep -c "$value") -eq 0 ]];
}

function _execute(){
  sudo -E -u "$SUDO_USER" DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$SUDO_UID/bus" gsettings set "$schema" "$key" "$value";
}