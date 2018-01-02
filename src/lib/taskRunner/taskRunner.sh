#!/usr/bin/env bash
# The MIT License (MIT)
# Copyright (c) Happystack


# TODO 📢
# ☑️


##
# Failsafe settings.
##
set -o errexit # Exit on error.
set -o errtrace # Exit on error inside any functions or subshells.
set -o nounset # Do not allow use of undefined vars. Use ${VAR:-} to use an undefined VAR
set -o pipefail # Catch the error in case mysqldump fails (but gzip succeeds) in `mysqldump |gzip`
# set -o xtrace
# Turn on traces, useful while debugging but commented out by default.


##
# Global constants.
##
readonly MPATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
readonly EMPTY=' '
readonly GREEN='\e[32m'
readonly RED='\e[31m'
readonly PURPLE='\e[38;5;105m'
readonly DONESTATUS='Done'
readonly INPROGRESSSTATUS='In progress'
readonly FAILEDSTATUS='Failed'


# size
# readonly WIDTH="$(tput cols)"
readonly HEIGHT="$(tput lines)"


##
# Imports.
##
readonly row="${MPATH}/../table/row.sh"
readonly loader="${MPATH}/../loader/loader.sh"
readonly progressBar="${MPATH}/../progressBar/progressBar.sh"
# shellcheck source=./../templates.sh
source "${MPATH}/../templates.sh"
# shellcheck source=./../helpers.sh
source "${MPATH}/../helpers.sh"
# shellcheck source=./../icons.sh
source "${MPATH}/../icons.sh"



##
# Constants
##
readonly start=`date +%s`


##
# Global variables
##
currentVersion=0.0.0
currentStep=0


##
# printTask
#
# @desc: return the step row according to its state
#
# @usage: printTask <task> [--default|--error|--progress|--done]
#
##
printTask() {
  local task="${1}"
  local content
  local leftContent
  local rightContent
  local middleContent
  local middleLength

  case $2 in
    --error)
      # left
      leftContent+="${ERRORICON} "
      leftContent+="${EMPTY}${RED}${task}"
      # right
      rightContent+="[${FAILEDSTATUS}]"
      # center
      middleLength=$(( WIDTH - ${#leftContent} - ${#rightContent} - 6 ))
      ;;
    --progress)
      # left
      leftContent+="${TIMEICON} "
      leftContent+="${EMPTY}${task}"
      # right
      rightContent+="${PURPLE}[${INPROGRESSSTATUS}]"
      # center
      middleLength=$(( WIDTH - ${#leftContent} - ${#rightContent} ))
      ;;
    --done)
      # left
      leftContent+="${SUCCESSICON} "
      leftContent+="${EMPTY}${GREEN}${task}"
      # right
      rightContent+="[${DONESTATUS}]"
      # center
      middleLength=$(( WIDTH - ${#leftContent} - ${#rightContent} - 6 ))
      ;;
    *)
      # left
      leftContent+="${ARROWICON} "
      leftContent+=" ${task}"
      # center
      middleLength=0
      ;;
  esac

  # middle dot to filled between left and right
  for (( k = 0; k < "${middleLength}"; k++ )); do
    middleContent+='.'
  done

  # build content
  content="${EMPTY}${EMPTY}${EMPTY}"
  content+="${leftContent}"
  content+="${middleContent}"
  content+="${rightContent}"

  printf "$( bash $row middle --content="${content}" --align='left' )"
}



##
# statusFooter
#
# @desc: append a status footer to the table
#
# @usage: statusFooter <time> [--success|--failure]
#
##
statusFooter() {
  local message
  local sound
  local time="${1}"

  case $2 in
    --success)
      message="🎉${EMPTY}${EMPTY}Deployed to version $currentVersion in ${time} seconds!"
      sound='success.wav'
      ;;
    --failure)
      message="💩${EMPTY}${EMPTY}Error log: cat /err.log. Ran in ${time} seconds!"
      sound='failure.wav'
      ;;
  esac

  printf '\n'
  removeLines 1
  printf "$( bash $row separator )"
  printf "$( bash $row middle )"
  printf "$( bash $row middle --content="${message}" --align='center' )"
  printf "$( bash $row middle )"
  printf "$( bash $row bottom )"

  # BIB!
  sleep 0.2
  afplay "${MPATH}/../taskRunner/sounds/${sound}" || paplay "${MPATH}/../taskRunner/sounds/${sound}" || echo -ne '\007'

  # place cursor to bottom
  tput cup "${HEIGHT}" 0

  # unhideCursor
  unhideCursor
}


##
# printTable
#
# @desc: print the table with all the tasks
#
# @usage: printTable
#
##
printTable() {
  local headerColumns=()
  local headerContent
  local padding=3

  # print header
  printf '\033[;H' || clear
  printf "$( templateHeader 'HAPPYSTACK BASHKIT' 'Deploy script' )"

  # table header
  headerContent+="${EMPTY}${EMPTY}Current version ${currentVersion}~"
  headerContentLength="$(( ${#headerContent} + padding - 1 ))"

  # add progress bar to headerContent
  local progressBarWidth=$(( WIDTH - headerContentLength - (padding * 2) - 1  ))
  progressContent="$( bash $progressBar "${progressBarWidth}" "${currentStep}" "${#tasks[*]}" )"
  headerContent+="${progressContent}~"

  # add table header columns
  headerColumns+=("${headerContentLength}")

  # print the table header rows
  printf "$( bash $row top --columns="${headerColumns[*]}" )"
  printf "$( bash $row middle --columns="${headerColumns[*]}" --content="${headerContent}" --align='left' )"
  printf "$( bash $row separator --columns="${headerColumns[*]}" --up )"
  printf "$( bash $row middle )"

  # body
  for (( i = 0; i < "${#tasks[*]}"; i++ )); do
    if [[ $i = "${currentStep}" ]]; then
      if [[ $# -eq 1 && $1 = '--error' ]]; then
        printTask "${tasks[i]}" --error
      else
        printTask "${tasks[i]}" --progress
      fi
    else
      if [[ $i -lt $currentStep ]]; then
        printTask "${tasks[i]}" --done
      else
        printTask "${tasks[i]}" --default
      fi
    fi
    printf "$( bash $row middle )"
  done

  # footer
  printf "$( bash $row bottom )"
}


##
# runTasks
#
# @desc: run a task
#
# @usage: runTask
#
##
runTasks() {
  # loop over all the tasks
  while [[ "${currentStep}" -lt $(( ${#tasks[*]} )) ]]; do
    # print the table
    printTable
    # run the current task and handle failure
    if eval "${tasksCommand[${currentStep}]}" > "${MPATH}/out.log" 2> "${MPATH}/err.log"; then
      # increment the current step
      currentStep=$(( $currentStep + 1 ))
    else
      # print error table
      printTable --error

      # print failure footer
      end=`date +%s`
      runtime=$((end-start))
      statusFooter $runtime --failure
      exit 0
    fi
  done
}


##
# init
#
# @desc: init the screen
#
# @usage: init
#
##
init() {
  # # start loader
  # bash "${loader}" &
  # loaderPID=$!
  # disown
  # # totally useless for now but damn cool
  # sleep 1.5
  # # stop loader
  # kill $loaderPID 2>/dev/null

  # import tasks
  # shellcheck source=./tasks.sh
  readonly CURRENTPATH=$( pwd )
  source "${CURRENTPATH}/${taskPath}"

  # init the screen
  hideCursor
  tput cup 0 0
  clear
}



##
# main
#
# @desc: configure and run the task runner
#
# @usage: main <taskPath> <currentVersion>
#
##
main() {
  # failsafe
  if [[ ${#2} = 0 ]]; then
    exit 1
  fi

  # Variables
  local taskPath=$1
  currentVersion=$2

  # init the screen
  init

  # run tasks
  runTasks

  # success finish
  currentStep=$(( $currentStep + 1 ))
  printTable

  # print success footer
  end=`date +%s`
  runtime=$((end-start))
  statusFooter $runtime --success

  # exit program
  exit 0
}

# Call `main` after everything has been defined.
main "$@"
