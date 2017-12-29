#!/usr/bin/env bash
# The MIT License (MIT)
# Copyright Happystack


# colors
readonly DEFAULTCOLOR='\e[39m'
readonly LIGHTGREY='\e[38;5;240m'


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


##
# concateRow
#
# @desc: concat the row string with left, fill and right.
#
# @usage: concateRow <left> <fill> <right>
##
concateRow() {
  # failsafe for having all required parameters
  if [[ "${#@}" -lt 3 ]]; then
    echo 'usage: concateRow <left> <fill> <right>'  >&2
    exit 1
  fi

  # variables
  local row
  local left="${1}"
  local fill="${2}"
  local right="${3}"

  # build the row
  row+="${LIGHTGREY}${left}"
  row+="${fill}"
  row+="${right}${DEFAULTCOLOR}"

  # export row
  echo "${row}"
}


##
# row
#
# @desc: concate and return a row
#
# @usage: row <top|middle|bottom|separator> [options]
#
# @options:
#   --column={array}
#   --content={array}
#   --up
#   --down
#   --cross
#
# @examples:
#   row top
#   row top --columns="${colsArray}"
#   row middle
#   row separator
#   row separator --columns="${colsArray}" --up
##
row() {
  # variables
  local row
  local left
  local right
  local fill
  local fillContent
  local columns
  local rowType
  local separator="${XLINE}"

  # get positional parameters
  for i in "$@"
  do
    local option="${i}"
    case "${option}" in
      top)
        left="${TOPLEFTCORNER}"
        right="${TOPRIGHTCORNER}"
        rowType='top'
        separator="${TOPSEPARATOR}"
        shift
        ;;
      bottom)
        left="${BOTTOMLEFTCORNER}"
        right="${BOTTOMRIGHTCORNER}"
        rowType='bottom'
        separator="${BOTTOMSEPARATOR}"
        shift
        ;;
      middle)
        left="${YLINE}"
        right="${YLINE}"
        rowType='middle'
        separator="${YLINE}"
        shift
        ;;
      separator)
        left="${LEFTSEPARATOR}"
        right="${RIGHTSEPARATOR}"
        rowType='separator'
        shift
        ;;
      --up)
        separator="${BOTTOMSEPARATOR}"
        shift
        ;;
      --down)
        separator="${TOPSEPARATOR}"
        shift
        ;;
      --cross)
        separator="${CROSSINGSEPARATOR}"
        shift
        ;;
      --columns=*)
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
      --content=*)
        # pull array from args
        IFS=', ' read -r -a content <<< "${option#*=}"
        unset IFS
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
  local contentCursor=0
  while [  $i -lt $(( WIDTH - 2 )) ]; do
    # if the columns option is passed we will place the separators
    if [[ ${#columns} != 0 && $i = "${columns[$cursor]}" ]]; then
      # place the separator
      fill+="${separator}"
      # increment the cursor to the next column
      if [[ $cursor -lt "(( ${#columns[@]} - 1 ))" ]]; then
        ((cursor+=1))
      fi
    else
      # choose between filling with XLINES or empty spaces
      if [[ ${#content} != 0 && $i = "$contentCursor" ]]; then
        [[ $rowType = 'middle' ]] && fillContent="${content[$cursor]}" || fillContent="${XLINE}"
        # place the symbol
        fill+="${fillContent}"

        # update contentCursor
        contentCursor=$(( ${columns[$cursor]} + 1 ))
      else
        [[ $rowType = 'middle' ]] && fillContent=' ' || fillContent="${XLINE}"
        # place the symbol
        fill+="${fillContent}"
      fi

    fi

    ((i+=1))
  done


  # build the panel row
  row="$( concateRow "${left}" "${fill}" "${right}" )"

  # export row
  echo "${row}"
}


# failsafe for having all required parameters
if [[ "${#@}" -lt 1 ]]; then
  echo 'pass the correct paramaters'  >&2
  exit 1
fi

# Call `row` after everything has been defined.
row "$@"
