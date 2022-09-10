#!/bin/bash

# Add your script description on this constant.
readonly _description="Enable dark mode";

# Define your constants and functions on this function.
function _setUp() {
    config_file_path=$HOME/.config/gtk-4.0/settings.ini
}

# Unset your constants and functions on this function.
function _tearDown() {
    unset config_file_path;
}

# Create a logic to verify if it is necessary to execute the scirpt.
function _verify() {
    if [[ ! -f $config_file_path ]];
	then
		return 0;
	fi;

	grep "gtk-application-prefer-dark-theme=1" $config_file_path;
	return [[ $? -ne 0 ]];
}

# Create the logic to implement the proper system modifications here.
function _execute() {
    if [[ ! -f $config_file_path ]];
	then
		mkdir -p $(dirname $config_file_path);
		touch $config_file_path;
	fi;

	cat << EOF >> $config_file_path
[Settings]
gtk-application-prefer-dark-theme=1
EOF

}

function _manual_procedures() {
	echo -en "Please restart your Gnome Display Manager service with \"service gdm3 restart\" command.";
}