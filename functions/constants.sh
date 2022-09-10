#!/bin/bash

if [[ -n "$_constants_sh" ]]; then
  return
fi
_constants_sh=1

if [[ -z "$_temporary_directory" ]]; then
  readonly _temporary_directory="/tmp/ubuntu-post-installation"
fi
