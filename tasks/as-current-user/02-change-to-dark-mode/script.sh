#!/bin/bash

source $(dirname $BASH_SOURCE)/../../../commons/commons.sh

gsettings set org.gnome.desktop.interface gtk-theme $DARK_THEME;

log_info "GTK Theme replaced";