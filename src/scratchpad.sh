#!/usr/bin/env bash
# The MIT License (MIT)
# Copyright Happystack


# TODO 📢
# ☑️


##
# STRICT MODE
##
set -o errexit # Exit on error.
set -o nounset # Do not allow use of undefined vars. Use ${VAR:-} to use an undefined VAR
# Print a helpful message if a pipeline with non-zero exit code
trap 'echo "Aborting due to errexit on line $LINENO. Exit code: $?" >&2' ERR
set -o errtrace # Exit on error inside any functions or subshells.
set -o pipefail # Exit immediately if a pipeline returns non-zero.
# set -o xtrace
# Turn on traces, useful while debugging but commented out by default.


##
# Global constants.
##
readonly MPATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"


##
# Imports.
##
readonly row="${MPATH}/lib/table/row.sh"
readonly loader="${MPATH}/lib/loader/loader.sh"
readonly taskRunner="${MPATH}/lib/taskRunner/taskRunner.sh"
# shellcheck source=./lib/templates.sh
source "${MPATH}/lib/templates.sh"
# shellcheck source=./lib/helpers.sh
source "${MPATH}/lib/helpers.sh"


##
# Scratchpad start here:
##


bash "${taskRunner}" 'tasks.sh' '0.3.1'

exit 0

# array=()
# array+=(4)
# array+=(9)
# array+=(20)
# array+=(50)
# # array+=(12)
#
# content=()
# content+=('A')
# content+=('BBB')
# content+=('\e[38;5;105mCKKK\e[39m')
# content+=('DDD')
# content+=('EE')
# # content+=('F')
#
# printf "$( templateHeader 'Deploy script' )"
# printf "$( bash "${row}" top )"
# printf "$( bash ${BINPATH}/lib/table/row.sh separator --columns="${array[*]}" --down )"
# printf "$( bash ${BINPATH}/lib/table/row.sh middle --columns="${array[*]}" --content="${content[*]}" --align='center' )"
# # printf "$( bash ${BINPATH}/lib/table/row.sh middle --columns="${array[*]}" )"
# # printf "$( bash ${BINPATH}/lib/table/row.sh middle )"
# printf "$( bash ${BINPATH}/lib/table/row.sh bottom --columns="${array[*]}" )"
# # printf "$( panelRow --middle --content="dude" )"
# # printf "$( panelRow --top --sections="${contentArray}" )"
# # printf "$( panelRow --middle --sections="${contentArray}" )"
# # printf "$( panelRow --separator=cross --sections="${contentArray}" )"
# # printf "$( panelRow --bottom --sections="${contentArray}" )"
