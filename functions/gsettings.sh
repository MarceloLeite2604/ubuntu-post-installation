#!/bin/bash

if [[ -n "$_gsettings_sh" ]]; then
  return
fi
_gsettings_sh=1

function _check_gsettings_key() {
  local schema="$1"
  local key="$2"
  local value="$3"
  [[ $(gsettings get "$schema" "$key" 2>/dev/null | grep -c "$value") -eq 0 ]];
}

function _set_gsettings_key() {
  local schema="$1"
  local key="$2"
  local value="$3"
  sudo -E -u "$SUDO_USER" DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$SUDO_UID/bus" gsettings set "$schema" "$key" "$value";
}