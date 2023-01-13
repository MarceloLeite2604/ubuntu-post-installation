#!/bin/bash

if [[ -n "$_programs_sh" ]]; then
  return
fi
_programs_sh=1

function _find_binary() {
  local binary="$1"

  which "$binary" >/dev/null 2>&1;
}

function _find_snap_package() {
  local package="$1"

  snap list "$package" >/dev/null 2>&1
}

function _find_apt_package() {
  local package="$1"
  [[ $(apt -qq --installed list curl 2>/dev/null | wc -l) -ne 0 ]];
}