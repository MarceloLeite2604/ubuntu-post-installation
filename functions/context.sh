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

  if [[ $(type -t _setUp) != function ]]; then
    echo >&2 "\"_setUp\" function is not set."
    return 1
  fi

  if [[ $(type -t _verify) != function ]]; then
    echo >&2 "\"_verify\" function is not set."
    return 1
  fi

  if [[ $(type -t _execute) != function ]]; then
    echo >&2 "\"_execute\" function is not set."
    return 1
  fi

  if [[ $(type -t _tearDown) != function ]]; then
    echo >&2 "\"_tearDown\" function is not set."
    return 1
  fi

  return 0
}

function _load_context() {
  local script="$1"

  if [[ ! -f "$script" ]]; then
    echo >&2 "Could not find script \"$script\"."
    return 1
  fi

  # shellcheck source=/dev/null
  source "$script"
  return 0
}

function _clear_context() {
  unset _description
  unset -f _set_up
  unset -f _verify
  unset -f _execute
  unset -f _tear_down
  unset -f _manual_procedures
}