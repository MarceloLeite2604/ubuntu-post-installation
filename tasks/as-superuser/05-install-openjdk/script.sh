#!/bin/bash

source $(dirname $BASH_SOURCE)/../../../commons/commons.sh

echo "Available OpenJDK versions to install:"
apt-cache pkgnames openjdk | grep -- -jdk | grep -v headless | sort;
echo -n "Please inform OpenJDK version number you want to install (numbers only): ";
read version;

if [[ ! $version =~ [0-9]+ ]];
then
	echo "Invalid value for OpenJDK version!" >&2;
	exit 1;
fi;

package=openjdk-$version-jdk
if [[ -z $(apt-cache search --names-only ^$package$) ]];
then
	echo "Invalid value for OpenJDK version!" >&2;
	exit 1;
fi;

apt install $package -y;
