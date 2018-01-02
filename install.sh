#!/usr/bin/env bash
# The MIT License (MIT)
# Copyright (c) Happystack


# Constants
readonly PACKAGE='bashrunner'
readonly GITURL='https://github.com/happystacklabs/bashrunner.git'
readonly INSTALLDIR="${INSTALLDIR}"


##
# isGitInstalled
#
# @desc: Check if git is installed and return a bool value.
#
# @usage: isGitInstalled
##
isGitInstalled() {
  type "git" > /dev/null 2>&1
}


##
# install
#
# @desc: Install the script from git.
#
# @usage: install
##
install() {
  # install in /usr/local/PACKAGE
  [ -z "${INSTALLDIR}" ] && INSTALLDIR="/usr/local/${PACKAGE}"
  # check if already installed
  if [[ -e "${INSTALLDIR}" ]]; then
    # update the package from git
    echo "${PACKAGE}: already installed!"
    echo "Now updating from git"
    # fetch from git url
    command git --git-dir="${INSTALLDIR}/.git" --work-tree="${INSTALLDIR}" fetch --depth=1 || {
      echo >&2 "Failed to fetch changes from ${GITURL}"
      exit 1
    }
    # reset from git url
    command git --git-dir="${INSTALLDIR}/.git" --work-tree="${INSTALLDIR}" reset --hard origin/master || {
      echo >&2 "Failed to reset changes from ${GITURL}"
      exit 1
    }
  else
    # fresh install from git
    echo "${PACKAGE}: Downloading from git to ${INSTALLDIR}"
    # clone from git url
    command git clone --depth 1 ${GIT_URL} ${INSTALL_DIR} || {
      echo >&2 "Failed to clone FROM ${GITURL}"
      exit 1
    }
    # set permissions
    chmod -R 755 ${INSTALLDIR}/lib 2>/dev/null
    chmod 755 "${INSTALLDIR}/${PACKAGE}" 2>/dev/null
    sudo ln -sf "${INSTALLDIR}/${PACKAGE}" "/usr/local/bin/${PACKAGE}"
  fi
}


##
# main
#
# @desc: entry point.
#
# @usage: main
##
main() {
  if isGitInstalled; then
    install
  else
    echo >&2 "Failed, this installation script need git installed first."
  fi


  # check directory
  [ -z "${INSTALLDIR}" ] && INSTALLDIR="/usr/local/${PACKAGE}"


  # handle success or failure
  if [[ -f "${INSTALLDIR}/${PACKAGE}" ]]; then
    echo 'done!'
  else
    echo >&2 "Failed, ${INSTALLDIR}/${PACKAGE} was not found"
    exit 1
  fi
}


# run install script
main "$@"
