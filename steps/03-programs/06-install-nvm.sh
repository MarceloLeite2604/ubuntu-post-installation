#!/bin/bash

#!/bin/bash

# Add your script description on this constant.
_description="Install nvm."

# Create a logic to verify if it is necessary to execute the scirpt.
function _check_step_is_necessary() {
  [[ ! -d ~/.nvm ]]
}

# Create the logic to implement the proper system modifications here.
function _execute() {
  sudo -Eu "$SUDO_USER" bash -c "curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash";
}