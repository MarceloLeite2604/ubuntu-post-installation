#!/bin/bash

gsettings set org.gnome.shell.extensions.dash-to-dock autohide 'false';

gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed 'false';

gsettings set org.gnome.shell.extensions.dash-to-dock intellihide 'false';

function _check_step_is_necessary() {
  _check_gsettings_key "$schema" "$key" "$value"
}

function _execute(){
  _set_gsettings_key "$schema" "$key" "$value"
}