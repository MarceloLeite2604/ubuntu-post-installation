#!/bin/bash

_description="Enabling dark mode"

config_file_path=$HOME/.config/gtk-4.0/settings.ini

function _check_step_is_necessary() {
  if [[ ! -f $config_file_path ]]; then
    return 0
  fi

  [[ $(grep -c "gtk-application-prefer-dark-theme=1" "$config_file_path") -eq 0 ]];
}

function _execute() {
  if [[ ! -f "$config_file_path" ]]; then
    mkdir -p "$(dirname "$config_file_path")"
    touch "$config_file_path"
  fi

  cat <<EOF >>"$config_file_path"
[Settings]
  gtk-application-prefer-dark-theme=1
EOF
}

function _manual_procedures() {
  cat <<EOF
Please restart your Gnome Display Manager service with "service gdm3 restart" command.
EOF
}
