#!/usr/bin/env bash
# The MIT License (MIT)
# Copyright Happystack


##
# panelRow
#
# @desc: return a row of a panel
#
# @usage: panelRow --position [top|bottom|middle|separator]
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
  readonly XLINE='─'
  readonly YLINE='│'

  # variables
  local row
  local left
  local middle
  local right
  local middleContent

  # get positional parameters
  for i in "$@"
  do
    case "${i}" in
      -p=*|--position=*)
        readonly local POSITION="${i#*=}"

        # verify and set position
        case "${POSITION}" in
          'top')
            left="${TOPLEFTCORNER}"
            right="${TOPRIGHTCORNER}"
            ;;
          'bottom')
            left="${BOTTOMLEFTCORNER}"
            right="${BOTTOMRIGHTCORNER}"
            ;;
          'middle')
            left="${YLINE}"
            right="${YLINE}"
            ;;
          'separator')
            left="${LEFTSEPARATOR}"
            right="${RIGHTSEPARATOR}"
            ;;
          *)
            echo "Error: Unknown argument: ${POSITION}" >&2
            exit 1
        esac

        # past argument=value
        shift
        ;;
      *)  # No more options
        echo "Error: Unknown option: $1" >&2
        exit 1
        ;;
    esac
  done

  # filling the rest of the width between the two edge of the panel.
  [[ $POSITION = 'middle' ]] && middleContent=' ' || middleContent="${XLINE}"
  local i=0
  while [  $i -lt $(( WIDTH - 2 )) ]; do
    middle+="${middleContent}"
    ((i+=1))
  done

  # build the panel top
  row+="${LIGHTGREY}${left}"
  row+="${middle}"
  row+="${right}${DEFAULTCOLOR}"

  # export
  echo "${row}"
}
