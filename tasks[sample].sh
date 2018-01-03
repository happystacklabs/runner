#!/usr/bin/env bash
# The MIT License (MIT)
# Copyright (c) Happystack


# shellcheck disable=SC2034
tasks=()
tasksCommand=()



# Do not change content before here.
#
# How to use
# ----------
# To add a new task, add the task title and the command.
#
# tasks[n]='Task title'
# tasksCommand[n]='the bash command'
#
# where 'n' is the index of the task
#
#
################################################################################
# Your custom content for the display, title and subtitle
################################################################################
display=0.0.0
# Example:
# display="Current Version: $(grep -m1 version package.json | awk -F: '{ print $2 }' | sed 's/[", ]//g')"
title='HAPPYSTACK 🏃🏼'
subtitle='Tasks Runner'

################################################################################
# Task 1
################################################################################
# task1() {
#   bash "${input}" "label" "action"
# }

tasks[1]='Task one'
# tasksCommand+=(task1)
tasksCommand[1]='sleep 3.0'

###############################################################################
# Task 2
###############################################################################
tasks[0]='Task two'
tasksCommand[0]='sleep 1.0'


################################################################################
# Task 3
################################################################################
# tasks[2]='Task three'
# tasksCommand[2]='sleep 5.0'
