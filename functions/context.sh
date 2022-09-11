#!/bin/bash

if [[ -n "$_context_sh" ]]; then
  return
fi
_context_sh=1

_script_directory=$(dirname "${BASH_SOURCE[0]}")

source "$_script_directory"/log.sh

function _check_context() {
  if [[ -z "$_description" ]]; then
    _log "\"_description\" variable is not set." "ERROR" "$_log_no_header"
    return 1
  fi

  if [[ $(type -t _check_step_is_necessary) != function ]]; then
    _log "\"_check_step_is_necessary\" function is not set." "ERROR" "$_log_no_header"
    return 1
  fi

  if [[ $(type -t _execute) != function ]]; then
    _log "\"_execute\" function is not set." "ERROR" "$_log_no_header"
    return 1
  fi

  return 0
}

function _load_context() {
  local script_location="$1"

  if [[ ! -f "$script_location" ]]; then
    _log "Could not find script \"$script_location\"." "ERROR" "$_log_no_header"
    return 1
  fi

  # shellcheck source=/dev/null
  source "$script_location"
  return 0
}

function _clear_context() {
  unset _description
  unset -f _check_step_is_necessary
  unset -f _execute
  unset -f _manual_procedures
}