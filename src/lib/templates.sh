#!/usr/bin/env bash
# The MIT License (MIT)
# Copyright Happystack


##
# templateHeader
#
# @desc: return the Happystack header
#
# @usage: templateHeader [ subtitle: {string} ]
##
templateHeader() {
  # colors
  readonly DEFAULTCOLOR='\e[39m'
  readonly PURPLE='\e[38;5;105m'
  
  # default value
  local subtitle='A Bash script'

  # set subtitle value if argument passed
  if [[ $# -eq 1 ]] ; then
    subtitle="${1}"
  fi

  # export
  echo "
    /\═════════\™
   /__\‸_____/__\‸
  │    │         │   ${PURPLE}HAPPYSTACK KIT${DEFAULTCOLOR}
  │    │  \___/  │   ${subtitle}
  ╰────┴─────────╯\n
"
}
