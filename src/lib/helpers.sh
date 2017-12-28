#!/usr/bin/env bash
# The MIT License (MIT)
# Copyright Happystack


##
# removeLines
#
# @desc: remove 'n' number of lines from current position.
#
# @usage: removeLines [ n: {number} ]
##
removeLines() {
  # default to 1
  local n=1

  # set n value if argument passed
  if [[ $# -eq 1 ]] ; then
    n="${1}"
  fi

  # iterate n times
  local i=0
  while [  $i -lt $n ]; do
    # clear to end of line
    tput el
    # up one line
    tput cuu1
    # clear to end of line
    tput el
    ((i+=1))
  done
}


##
# spaces
#
# @desc: add 'n' number of spaces.
#
# @usage: spaces [ n: {number} ]
##
spaces() {
  # default to 1
  local n=1

  # set n value if argument passed
  if [[ $# -eq 1 ]] ; then
    n="${1}"
  fi

  # iterate n times
  local i=0
  while [  $i -lt $n ]; do
    printf " "
    ((i+=1))
  done
}


##
# stopAnimation
#
# @desc: stop the animation in the background process.
#
# @usage: stopAnimation
##
stopAnimation() {
  kill "$!"
  wait $! 2>/dev/null
}


##
# hideCursor
#
# @desc: make the cursor invisible.
#
# @usage: hideCursor
##
hideCursor() {
  tput civis
}


##
# unhideCursor
#
# @desc: make the cursor visible.
#
# @usage: unhideCursor
##
unhideCursor() {
  tput cvvis
}
