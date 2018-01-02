#!/usr/bin/env bash
# The MIT License (MIT)
# Copyright Happystack


# TODO 📢
# ☑️  Start animation.
# ☑️  Stop animation.
# ☑️


# global constants
readonly MPATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"


# size
readonly WIDTH="$(tput cols)"
readonly HEIGHT="$(tput lines)"
readonly MATRIXWIDTH=10
readonly MATRIXHEIGHT=4


# symbols
readonly DOUBLETOP='╔╗'
readonly DOUBLEBOTTOM='╚╝'
readonly THICKTOP='┏┓'
readonly THICKBOTTOM='┗┛'
readonly THICKYLINE='┃'
readonly SPACE=" "
readonly EMPTY="${SPACE}${SPACE}"
readonly NEWLINE='\n'


# colors
readonly DEFAULTCOLOR='\e[39m'
readonly PURPLE='\e[38;5;105m'
readonly LIGHTPURPLE='\e[38;5;104m'
# readonly FADEDPURPLE='\e[38;5;103m'


# padding
readonly TOPPADDING=$(( (HEIGHT - MATRIXHEIGHT + 1) / 2 ))
readonly BOTTOMPADDING=$(( HEIGHT - MATRIXHEIGHT - TOPPADDING - 1 ))
readonly LEFTPADDING=$(( ((WIDTH + 1) / 2) - MATRIXWIDTH  ))


# time
readonly TIME=0.16

# imports
# shellcheck source=./frames.sh
source "${MPATH}/frames.sh"
echo "${MPATH}/frames.sh"

# Loader matrix
# ╭──┬────┬──┬────┬──┬────┬──╮
# │0 │ 1  │2 │ 3  │4 │ 5  │6 │
# ├──┼────┼──┼────┼──┼────┼──┤
# │7 │ 8  │9 │ 10 │11│ 12 │13│
# ├──┼────┼──┼────┼──┼────┼──┤
# │14│ 15 │16│ 17 │18│ 19 │20│
# ├──┼────┼──┼────┼──┼────┼──┤
# │21│ 22 │23│ 24 │25│ 26 │27│
# ╰──┴────┴──┴────┴──┴────┴──╯
#  7x4 (10x4)
#
# Content matrix
# ╭────┬────┬────╮
# │ 0  │ 1  │ 2  │
# ├────┼────┼────┤
# │ 3  │ 4  │ 5  │
# ├────┼────┼────┤
# │ 6  │ 7  │ 8  │
# ├────┼────┼────┤
# │ 9  │ 10 │ 11 │
# ╰────┴────┴────╯
#  3x4
#
# Example
# ╭─┬────┬──┬────┬──┬────┬──╮
# │P│    │  │ ┏┓ │  │    │\n│
# ├─┼────┼──┼────┼──┼────┼──┤
# │P│ ╔╗ │  │ ┗┛ │  │ ╔╗ │\n│
# ├─┼────┼──┼────┼──┼────┼──┤
# │P│ ╚╝ │  │    │  │ ╚╝ │\n│
# ├─┼────┼──┼────┼──┼────┼──┤
# │P│    │  │    │  │    │\n│
# ╰─┴────┴──┴────┴──┴────┴──╯
#  7x4


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
# printPadding
#
# @desc: Print the padding lines.
#
# @usage: printPadding [--top|--bottom]
#
# @private
##
printPadding() {
  local paddingLength

  case $1 in
    --top)
      paddingLength="${BOTTOMPADDING}"
      ;;
    --bottom)
      paddingLength="${TOPPADDING}"
      ;;
  esac

  # print n lines for padding
  for (( i = 0; i < $paddingLength; i++ )); do
    printf '\n'
  done
}


printFrame() {
  local frame=$1

  # top padding
  printPadding --top

  # print the matrix
  printf "$(loaderMatrix "${frame}")"

  # bottom padding
  printPadding --bottom
}


##
# loaderMatrix
#
# @desc: Takes the content and set the loader matrix with it.
#
# @usage: loaderMatrix <contentArray>
#
# @private
##
loaderMatrix() {
  local content=$1
  local loaderMatrix=()
  local leftPadding

  # force content to be an array
  IFS=', ' read -r -a content <<< "${content}"
  unset IFS

  # generate the left padding
  for (( i = 0; i < $LEFTPADDING; i++ )); do
    leftPadding+="${SPACE}"
  done

  # build the loader matrix
  # first row
  loaderMatrix[0]="${SPACE}${leftPadding}" #leftpadding
  loaderMatrix[1]="${content[0]}"
  loaderMatrix[2]="${SPACE}" #space
  loaderMatrix[3]="${content[1]}"
  loaderMatrix[4]="${SPACE}" #space
  loaderMatrix[5]="${content[2]}"
  loaderMatrix[6]="${DEFAULTCOLOR}${NEWLINE}" #newline

  # second row
  loaderMatrix[7]="${leftPadding}" #leftpadding
  loaderMatrix[8]="${content[3]}"
  loaderMatrix[9]="${SPACE}" #space
  loaderMatrix[10]="${content[4]}"
  loaderMatrix[11]="${SPACE}" #space
  loaderMatrix[12]="${content[5]}"
  loaderMatrix[13]="${DEFAULTCOLOR}${NEWLINE}" #newline

  # third row
  loaderMatrix[14]="${leftPadding}" #leftpadding
  loaderMatrix[15]="${content[6]}"
  loaderMatrix[16]="${SPACE}" #space
  loaderMatrix[17]="${content[7]}"
  loaderMatrix[18]="${SPACE}" #space
  loaderMatrix[19]="${content[8]}"
  loaderMatrix[20]="${DEFAULTCOLOR}${NEWLINE}" #newline

  # fourth row
  loaderMatrix[21]="${leftPadding}" #leftpadding
  loaderMatrix[22]="${content[9]}"
  loaderMatrix[23]="${SPACE}" #space
  loaderMatrix[24]="${content[10]}"
  loaderMatrix[25]="${SPACE}" #space
  loaderMatrix[26]="${content[11]}"
  loaderMatrix[27]="${DEFAULTCOLOR}${NEWLINE}" #newline

  # export
  echo "${loaderMatrix[*]}"
}



# launch the loading animation (infinite loop)
hideCursor

# clear screen
clear

while [[ 1 ]]; do
  for (( j = 0; j < ${#frames[@]}; j++ )); do
    # clear screen
    printf '\033[;H'
    #print the frame for x time
    printFrame "${frames[$j]}"
    sleep "${TIME}"
  done
done
