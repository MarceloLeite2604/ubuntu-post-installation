#!/bin/bash

sudo snap install intellij-idea-community --classic;
if [[ $? -ne 0 ]];
then
	echo "Something went wrong while installing IntelliJ IDEA Community edition." >&2;
	exit 1;
fi
