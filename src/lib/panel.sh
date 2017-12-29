#!/usr/bin/env bash
# The MIT License (MIT)
# Copyright Happystack


##
# panelRow
#
# @desc: return a row of a panel
#
# @examples:
#   panelRow --top
#   panelRow --top --columns="${colsArray}"
#   panelRow --middle
#   panelRow --separator
##
panelRow() {
  # colors
  readonly local DEFAULTCOLOR='\e[39m'
  readonly local LIGHTGREY='\e[38;5;240m'

  # size
  readonly WIDTH="$(tput cols)"
  readonly HEIGHT="$(tput lines)"

  # symbols
  readonly TOPLEFTCORNER='╭'
  readonly BOTTOMLEFTCORNER='╰'
  readonly TOPRIGHTCORNER='╮'
  readonly BOTTOMRIGHTCORNER='╯'
  readonly TOPSEPARATOR='┬'
  readonly BOTTOMSEPARATOR='┴'
  readonly LEFTSEPARATOR='├'
  readonly RIGHTSEPARATOR='┤'
  readonly CROSSINGSEPARATOR='┼'
  readonly XLINE='─'
  readonly YLINE='│'

  # variables
  local row
  local left
  local right
  local fill
  local fillContent
  local columns
  local position
  local separator

  # get positional parameters
  for i in "$@"
  do
    local option="${i}"
    case "${option}" in
      -t|--top)
        left="${TOPLEFTCORNER}"
        right="${TOPRIGHTCORNER}"
        position='top'
        separator="${TOPSEPARATOR}"
        shift
        ;;
      -b|--bottom)
        left="${BOTTOMLEFTCORNER}"
        right="${BOTTOMRIGHTCORNER}"
        position='bottom'
        separator="${BOTTOMSEPARATOR}"
        shift
        ;;
      -m|--middle)
        left="${YLINE}"
        right="${YLINE}"
        position='middle'
        separator="${YLINE}"
        shift
        ;;
      -s|--separator)
        left="${LEFTSEPARATOR}"
        right="${RIGHTSEPARATOR}"
        position='separator'
        separator="${CROSSINGSEPARATOR}"
        shift
        ;;
      -c=*|--columns=*)
        # pull array from args
        IFS=', ' read -r -a columns <<< "${option#*=}"
        unset IFS
        # and sort it
        columns=("$( printf "%s\n" "${columns[@]}" | sort -n )")
        # shellcheck disable=SC2128
        # shellcheck disable=SC2206
        columns=($columns)
        shift
        ;;
      -w=*|--content=*)
        #TODO change it
        readonly local CONTENT="${option#*=}"
        shift
        ;;
      *)
        # Unknown option
        echo "Error: Unknown option: $1" >&2
        exit 1
        ;;
    esac
  done


  # filling the rest of the width between the two edge of the panel.
  local i=0
  local cursor=0
  while [  $i -lt $(( WIDTH - 2 )) ]; do
    # if the columns option is passed we will place the separators
    if [[ ${#columns} != 0 && $i = "${columns[$cursor]}" ]]; then
      # place the separator
      fill+="${separator}"
      #now increment the cursor to the next column
      if [[ $cursor -lt "(( ${#columns[@]} - 1 ))" ]]; then
        ((cursor+=1))
      fi
    else
      # choose between filling with XLINES or empty spaces
      [[ $position = 'middle' ]] && fillContent=' ' || fillContent="${XLINE}"
      # place the symbol
      fill+="${fillContent}"
    fi

    ((i+=1))
  done


  # build the panel row
  row+="${LIGHTGREY}${left}"
  row+="${fill}"
  row+="${right}${DEFAULTCOLOR}"

  # export row
  echo "${row}"
}
