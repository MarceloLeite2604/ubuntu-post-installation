#!/bin/bash

if [[ -n "$_arguments_sh" ]]; then
  return
fi
_arguments_sh=1

_script_directory=$(dirname "${BASH_SOURCE[0]}")

source "$_script_directory"/log.sh

function _check_arguments() {

  UPI_DEBUG=1
  UPI_RESET_EXECUTION=1

  while getopts "dr" flag; do
    case $flag in
    d)
      UPI_DEBUG=0
      ;;
    r)
      UPI_RESET_EXECUTION=0
      ;;
    *)
      # shellcheck disable=SC2154
      _log "Illegal option." "ERROR" "$_log_no_header"
      return 1
      ;;
    esac
  done

  export UPI_DEBUG
  export UPI_RESET_EXECUTION

  return 0
}