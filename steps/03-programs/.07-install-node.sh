#!/bin/bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

nvm install node;
if [[ $? -ne 0 ]];
then
	echo "Something went wrong while installing NVM." >&2;
	exit 1;
fi

nvm use default;