#!/bin/bash

source $(dirname $BASH_SOURCE)/../../commons/commons.sh

DARK_THEME="'Adwaita-dark'";

[[ $(gsettings get org.gnome.desktop.interface gtk-theme) == $DARK_THEME ]] && exit $SKIPPED;