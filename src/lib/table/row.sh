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


cell() {
  local fill=()

  for (( i = 0; i < $1; i++ )); do
    fill+='-'
  done

  echo "${fill}"
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
  local columns
  local rowType
  local separator="${XLINE}"

  # get positional parameters and configure the script according to what was passed
  for i in "$@"; do
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


  # filling the row for separator and xline
  local columnCounter=0
  for (( x = 0; x < $(( WIDTH - 2 )); x++ )); do
    if [[ ${#columns} != 0 && $x = "${columns[$columnCounter]}" ]]; then
      # SEPARATOR
      if [[ $rowType != 'middle' ]]; then fill+="${separator}"; fi
      # increment columnCounter
      ((columnCounter+=1))
    else
      if [[ $rowType != 'middle' ]]; then fill+="${XLINE}"; fi
    fi
  done

  # filling the middle row with content
  if [[ $rowType = 'middle' ]]; then
    # fill n - 1 cells
    for (( i = 0; i < "${#columns[@]}"; i++ )); do

      local length
      # set the length of the cell
      if [[ $i = 0 ]]; then
        # first cell length is same than the first column x position
        length=$(( columns[i] ))
      else
        # the other cells length are the difference between current column and previous column
        length=$(( columns[i] - columns[i-1] - 1 ))
      fi
      # fill the cell
      fill+=$(cell "${length}")
      fill+="${YLINE}"
    done

    # fill last cell
    # local length=$(( WIDTH - columns[${#columns[@]}-1] - ( ${#columns[@]} + 1 ) ))
    local length=$(( ( WIDTH - 3 ) - columns[${#columns[@]}-1] ))
    fill+=$(cell "${length}")
  fi

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
