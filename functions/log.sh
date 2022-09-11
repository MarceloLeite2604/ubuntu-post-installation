#!/bin/bash

if [[ -n "$_log_sh" ]]; then
  return
fi
_log_sh=1

_log_style_info=$(tput setaf 2)
readonly _log_style_info

readonly _log_level_info="INFO"

_log_style_warn=$(tput setaf 3)
readonly _log_style_warn

readonly _log_level_warn="WARN"

_log_style_error=$(tput setaf 1)
readonly _log_style_error

readonly _log_level_error="ERROR"

readonly _log_no_header="_no_header";

_log_style_off=$(
  tput setaf 2
  tput sgr0
)
readonly _log_style_off

function _log() {
  local content="$1"

  local style=$_log_style_info
  local level=$_log_level_info
  if [[ $# -gt 1 ]]; then
    case "$2" in
    "INFO")
      style=$_log_style_info
      level=$_log_level_info
      ;;
    "WARN")
      style=$_log_style_warn
      level=$_log_level_warn
      ;;
    "ERROR")
      style=$_log_style_error
      level=$_log_level_error
      ;;
    *)
      echo >&2 "${_log_style_error}[${_log_level_error}] Unknown log style \"$2\".${_log_style_off}"
      style=$_log_style_info
      ;;
    esac
  fi

  local header=$_LOG_HEADER;
  if [[ $# -gt 2 ]]; then
    if [[ "$3" = "$_log_no_header" ]]; then
      header="";
    else
      header="$3";
    fi
  fi

  local message="${style}[${level}"
  if [[ -n "$header" ]]; then
   message+=" ${header}";
  fi;

  message+="] ${_log_style_off}${content}"

  if [[ $style = "ERROR" ]]; then
    echo >&2 "$message"
  else
    echo "$message"
  fi;
}

function _set_log_header(){
  export _LOG_HEADER="$1"
}

function _clear_log_header(){
  unset _LOG_HEADER
}