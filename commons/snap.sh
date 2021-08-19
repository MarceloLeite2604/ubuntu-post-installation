#!/bin/bash

# Include guard
[ -n "$_SNAP_SH" ] && return || readonly _SNAP_SH=1;

check_snap_package_is_installed() {
  readonly local package_name=$1;

  snap list | grep ^$package_name >> /dev/null;
  return;
}
