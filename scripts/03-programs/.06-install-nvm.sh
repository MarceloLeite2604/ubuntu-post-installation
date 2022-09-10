#!/bin/bash

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash;
if [[ $? -ne 0 ]];
then
	echo "Something went wrong while installing NVM." >&2;
	exit 1;
fi