#!/bin/bash

source $(dirname $BASH_SOURCE)/../../commons/commons.sh

[[ $(gsettings get org.gnome.desktop.interface gtk-theme) == $DARK_THEME ]] && exit $SKIP;