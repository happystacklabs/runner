#!/usr/bin/env bash
# The MIT License (MIT)
# Copyright Happystack


# TODO 📢
# ☑️


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
  # readonly PURPLE='\e[38;5;105m'

  # default value
  local title='HAPPYSTACK'
  local subtitle='A Bash script'

  # set subtitle value if argument passed
  if [[ $# -eq 2 ]] ; then
    title="${1}"
    subtitle="${2}"
  fi

  # export
  echo "
    /\═════════\™
   /__\‸_____/__\‸
  │    │         │   ${PURPLE}${title}${DEFAULTCOLOR}
  │    │  \___/  │   ${subtitle}
  ╰────┴─────────╯\n
"
}
