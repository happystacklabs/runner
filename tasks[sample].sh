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
# Task 1
################################################################################
tasks[0]='Task one'
tasksCommand[0]='sleep 2.0'

################################################################################
# Task 2
################################################################################
tasks[1]='Task two'
tasksCommand[1]='sleep 5.0'


################################################################################
# Task 3
################################################################################
tasks[2]='Task three'
tasksCommand[2]='sleep 5.0'