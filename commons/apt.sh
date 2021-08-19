#!/bin/bash

# Include guard
[ -n "$_APT_SH" ] && return || readonly _APT_SH=1;

check_apt_package_is_installed() {
  local package_name=$1;

  dpkg -l $package_name | grep ^ii >> /dev/null;
  return;
}

check_any_apt_package_installed_with_pattern() {
  local pattern=$1;
  dpkg-query -f '${Package}\n' -W | grep $pattern >> /dev/null;
  return
}