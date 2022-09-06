#!/bin/bash

sudo apt install curl;
if [[ $? -ne 0 ]];
then
	echo "Something went wrong while installing curl." >&2;
	exit 1;
fi
