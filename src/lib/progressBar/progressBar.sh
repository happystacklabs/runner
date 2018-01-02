#!/usr/bin/env bash
# The MIT License (MIT)
# Copyright (c) Happystack


# TODO 📢
# ☑️  Add the basic table.
# ☑️


##
# Global constants.
##
readonly EMPTY=' '
readonly PURPLE='\e[38;5;105m'


##
# progressBar
#
# @desc: return a progress bar
#
# @usage: progressBar <width> <currentStep> <stepsCount>
#
##
progressBar() {
  local barWidth="${1}"
  local currentStep="${2}"
  local stepsCount="${3}"
  local fill
  local padding=5

  # progress %
  progress=$(echo "scale=1;($currentStep / $stepsCount)*100" | bc -l)
    # limit progress to 100%
  if [ $currentStep -gt $stepsCount  ]; then
    progress=100
  fi

  # add progress with no decimals
  progress=$( printf "%0.0f" $progress)
  fill+=" ${progress}%% "

  # make one or two digit number take same width
  if [ ${#progress} -lt 2 ]; then
    padding=4
  fi
  if [ ${#progress} -gt 2 ]; then
    padding=6
  fi

  # print the progress
  barLength=$(( $1 - padding ))
  activeWidth=$(echo "($barLength / $stepsCount)*$currentStep" | bc -l)
  roundedActiveWidth=$(printf %.0f $activeWidth)

  for (( i = 0; i < $(( barWidth - padding )); i++ )); do
    if [[ $i -lt $roundedActiveWidth ]]; then
      fill+="${PURPLE}░"
    else
      fill+="${EMPTY}"
    fi
  done

  # export
  echo -e "${fill}"
}

progressBar "$@"
