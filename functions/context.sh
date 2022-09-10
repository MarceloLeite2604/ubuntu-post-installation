#!/bin/bash

if [[ -n "$_context_sh" ]]; then
  return
fi
_context_sh=1

function _check_context() {
  if [[ -z "$_description" ]]; then
    echo >&2 "\"_description\" variable is not set."
    return 1
  fi

  if [[ $(type -t _check_step_is_necessary) != function ]]; then
    echo >&2 "\"_check_step_is_necessary\" function is not set."
    return 1
  fi

  if [[ $(type -t _execute) != function ]]; then
    echo >&2 "\"_execute\" function is not set."
    return 1
  fi

  return 0
}

function _load_context() {
  local script_location="$1"

  if [[ ! -f "$script_location" ]]; then
    echo >&2 "Could not find script \"$script_location\"."
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