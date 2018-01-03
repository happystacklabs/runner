#!/usr/bin/env bash
# The MIT License (MIT)
# Copyright Happystack


# TODO 📢
# ☑️  handle empty columns and empty content
# ☑️  Add color feature.
# ☑️  Refactor cell and its helpers into its own file.
# ☑️


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
readonly SPACE=' '


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
  local row # string
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
# escapeString
#
# @desc: strip ascii color code out of the string
#
# @usage: escapeString <string>
##
escapeString() {
  local string="${1}"

  # strip the string out of ascii color code
  local escapedString
  escapedString=$(echo -e ${string} | sed "s/[\\]e\[[0-9;]*m//g")
  # escapedString=$(echo -e ${string} | sed "s/[\\]\d\d\d\[\d(m?)//g")


  # export escapeString
  echo "${escapedString}"
}


##
# cellSpacing
#
# @desc: return a string with the cell empty spaces
#
# @usage: cellSpacing <number of spaces>
##
cellSpacing() {
  # variables
  local fill=() # array

  # fill the cell with empty space
  for (( i = 0; i < $1; i++ )); do
    fill+=(${SPACE})
  done

  # export
  echo "$(printf "%s" "${fill[@]}")"
}


##
# cell
#
# @desc: return a string with the cell
#
# @usage: cell <content> <space length> <align>
##
cell() {
  # variables
  local fill=() # array
  local content="${1}"
  local length="${2}"
  local align="${3}"

  case $align in
    left)
      fill+=("${DEFAULTCOLOR}${content}${LIGHTGREY}")
      fill+=("$(cellSpacing "${length}")")
      ;;
    center)
      # variables
      local rightSpacing=$(( (length + 1) / 2 ))
      local contentEscaped
      contentEscaped=$( escapeString "${content}" )
      local leftSpacing=$(( length - rightSpacing ))
      # add the content to the cell
      fill+=("$(cellSpacing "${leftSpacing}")")
      fill+=("${DEFAULTCOLOR}${content}${LIGHTGREY}")
      fill+=("$(cellSpacing "${rightSpacing}")")
      ;;
    right)
      fill+=("$(cellSpacing "${length}")")
      fill+=("${DEFAULTCOLOR}${content}${LIGHTGREY}")
      ;;
  esac


  # export
  echo "$(printf "%s" "${fill[@]}")"
}


##
# content
#
# @desc: return a string with the row content with formatted cells
#
# @usage: content <columnsArray> <contentArray> <align>
##
content() {
  local columns=$1
  local content=$2
  local align=$3
  local fill

  IFS=', ' read -r -a columns <<< "${columns}"
  IFS='~' read -r -a content <<< "${content}"
  unset IFS

  # if no content just fill the row with empty
  if [[ ${#content} = 0 ]]; then
    cellLength=$(( WIDTH - 2 ))
    echo "$(cellSpacing "${cellLength}")"
    return
  fi

  # if no columns just fill the row with empty after content
  if [[ ${#columns} = 0 ]]; then
    local contentEscaped
    contentEscaped=$( escapeString "${content}" )
    local contentLength="${#contentEscaped}"
    local rowLength=$(( WIDTH - 2 - contentLength ))

    fill+=$(cell "${content}" "${rowLength}" "${align}")
    echo "${fill}"
    return
  fi

  # loop over the n-1 cells
  for (( i = 0; i < "${#columns[@]}"; i++ )); do
    local cellLength
    local contentEscaped
    contentEscaped=$( escapeString "${content[i]}" )
    local contentLength="${#contentEscaped}"
    # set the length of the cell
    if [[ $i = 0 ]]; then
      # first cell length is same than the first column x position
      cellLength=$(( columns[i] - contentLength ))
      # echo $cellLength
    else
      # the other cells length are the difference between current column and previous column
      cellLength=$(( columns[i] - columns[i-1] - contentLength  - 1 ))
      # echo $cellLength
    fi
    # fill the cell
    fill+=$(cell "${content[i]}" "${cellLength}" "${align}")
    fill+="${YLINE}"
  done

  # fill the last cell
  local lastCellLength
  local lastContentEscaped
  lastContentEscaped=$( escapeString "${content[${#content[@]}-1]}" )
  local lastContentLength="${#lastContentEscaped}"

  # get the last cell length
  lastCellLength=$(( ( WIDTH - 3 ) - columns[${#columns[@]}-1] - lastContentLength ))

  # fill the last cell
  fill+=$(cell "${content[${#columns[@]}]}" "${lastCellLength}" "${align}")

  # export fill
  echo "${fill}"
}


##
# border
#
# @desc: return a string with the border row
#
# @usage: content <columnsArray> <separator>
##
border() {
  local columns=$1
  local separator=$2

  IFS=', ' read -r -a columns <<< "${columns}"
  unset IFS
  # columns
  # separator
  # export: fill
  for (( i=0, j=0; i < $(( WIDTH - 2 )); i++ )); do
    if [[ ${#columns} != 0 && $i = "${columns[$j]}" ]]; then
      fill+="${separator}"
      ((j+=1))
    else
      fill+="${XLINE}"
    fi
  done

  echo "${fill}"
}


##
# row
#
# @desc: concate and return a row
#
# @usage: row [top|middle|bottom|separator] [options]
#
# @options:
#   --column=columnArray
#   --content=contentArray
#   --up
#   --down
#   --cross
#   --align=[left|center|right]
#
# @examples:
#   row top
#   row top --columns={colsArray}
#   row middle --columns=colsArray --content=contentArray
#   row middle --columns=colsArray --content=contentArray --align=center
#   row separator
#   row separator --columns={colsArray" --up
##
row() {
  # variables
  local row
  local left
  local right
  local fill
  local columns
  local rowType
  local separator="${XLINE}" # default value to XLINE
  local content
  local align='left' # default value to left

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
        content="${option#*=}"
        shift
        ;;
      --align=*)
      # get option
        align="${i#*=}"
        # failsafe
        if [[ $align != 'left' &&  $align != 'center' && $align != 'right' ]]; then
          echo '--align was passed the wrong option.' >&2
          exit 1
        fi
        ;;
      *)
        # Unknown option
        echo "Error: Unknown option: $1" >&2
        exit 1
        ;;
    esac
  done

  # deal with a border row or a content row
  if [[ $rowType != 'middle' ]]; then
    # fill the row with its border content
    fill+="$( border "${columns[*]}" "${separator}" )"
  else
    # fill the row with content
    fill+="$( content "${columns[*]}" "${content}" "${align}" )"
  fi

  # build the table row
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
