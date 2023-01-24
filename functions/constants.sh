#!/bin/bash

if [[ -n "$_constants_sh" ]]; then
  return
fi
_constants_sh=1

if [[ -z "$_temporary_directory" ]]; then
  _temporary_directory="/tmp/ubuntu-post-installation"
  readonly  _temporary_directory;
fi

if [[ -z "$_cache_directory" ]]; then
  _cache_directory="$_temporary_directory/cache"
  readonly _cache_directory;
fi