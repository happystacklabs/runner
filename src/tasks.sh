#!/usr/bin/env bash
# The MIT License (MIT)
# Copyright (c) Happystack


##
# Failsafe settings.
##
set -o errexit # Exit on error.
set -o errtrace # Exit on error inside any functions or subshells.
set -o nounset # Do not allow use of undefined vars. Use ${VAR:-} to use an undefined VAR
set -o pipefail # Catch the error in case mysqldump fails (but gzip succeeds) in `mysqldump |gzip`
# set -o xtrace
# Turn on traces, useful while debugging but commented out by default.


##
# Add Tasks here.
##
tasks=()
tasks+=('Task one')
tasks+=('Task two') # append more tasks.
