#!/bin/bash

config_file_path=~/.config/gtk-4.0/settings.ini

if [[ ! -f $config_file_path ]];
then
	mkdir -p $(dirname $config_file_path);
	touch $config_file_path;
fi;

cat << EOF >> $config_file_path
[Settings]
gtk-application-prefer-dark-theme=1
EOF

killall -SIGQUIT gnome-shell;
