#!/bin/bash

source $(dirname $BASH_SOURCE)/../../commons/commons.sh

DARK_THEME="'Adwaita-dark'";

# Skip condition
gsettings set org.gnome.desktop.interface gtk-theme $DARK_THEME;

log_info "GTK Theme replaced";