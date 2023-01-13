#!/bin/bash

if [[ -n "$_constants_sh" ]]; then
  return
fi
_constants_sh=1

if [[ -z "$_temporary_directory" ]]; then
  readonly _temporary_directory="/tmp/ubuntu-post-installation"
fi

if [[ -z "$_cache_directory" ]]; then
  readonly _cache_directory="$_temporary_directory/cache"
fi
