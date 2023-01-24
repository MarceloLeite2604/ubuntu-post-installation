#!/bin/bash

# Add your script description on this constant.
_description="Install Oh My Bash!"

# Create a logic to verify if it is necessary to execute the scirpt.
function _check_step_is_necessary() {
  [[ ! -d ~/.oh-my-bash ]];
}

# Create the logic to implement the proper system modifications here.
function _execute() {
  if ! _find_binary "curl"; then
    >&2 echo "Could not find \"curl\" binary.";
    return 1;
  fi;

  sudo -Eu "$SUDO_USER" bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)" --unattended;

  sed -i -E 's:OSH_THEME="?[^"]+"?:OSH_THEME="agnoster":g' ~/.bashrc

  printf "\nPROMPT_DIRTRIM=0\n" >> ~/.bashrc

  cat >>~/.bashrc <<EOF

prompt_context() {
  if [[ "\$USERNAME" != "\$DEFAULT_USER" || -n "\$SSH_CLIENT" ]]; then
    prompt_segment black default "";
  fi
}

EOF
}

# Add here additional procedures that must be done manually by the user.
# This function can be deleted if there are no additional procedures.
function _manual_procedures() {
  echo -n "Either restart your terminal session or create a new one to start using Oh-my-bash!"
}