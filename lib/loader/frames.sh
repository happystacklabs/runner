#!/usr/bin/env bash
# The MIT License (MIT)
# Copyright Happystack


# variables
frames=()
contentMatrix=()


################################################################################
# frame 1
# ╭────┬────┬────╮  ╭────┬────┬────╮
# │    │    │    │  │ 0  │ 1  │ 2  │
# ├────┼────┼────┤  ├────┼────┼────┤
# │ ╔╗ │ ╔╗ │ ╔╗ │  │ 3  │ 4  │ 5  │
# ├────┼────┼────┤  ├────┼────┼────┤
# │ ╚╝ │ ╚╝ │ ╚╝ │  │ 6  │ 7  │ 8  │
# ├────┼────┼────┤  ├────┼────┼────┤
# │    │    │    │  │ 9  │ 10 │ 11 │
# ╰────┴────┴────╯  ╰────┴────┴────╯
################################################################################
# first row
contentMatrix[0]="${EMPTY}"
contentMatrix[1]="${EMPTY}"
contentMatrix[2]="${EMPTY}"
# second row
contentMatrix[3]="${LIGHTPURPLE}${DOUBLETOP}"
contentMatrix[4]="${LIGHTPURPLE}${DOUBLETOP}"
contentMatrix[5]="${LIGHTPURPLE}${DOUBLETOP}"
# third row
contentMatrix[6]="${LIGHTPURPLE}${DOUBLEBOTTOM}"
contentMatrix[7]="${LIGHTPURPLE}${DOUBLEBOTTOM}"
contentMatrix[8]="${LIGHTPURPLE}${DOUBLEBOTTOM}"
# fourth row
contentMatrix[9]="${EMPTY}"
contentMatrix[10]="${EMPTY}"
contentMatrix[11]="${EMPTY}"


# add to steps
frames+=("${contentMatrix[*]}")

################################################################################
# frame 2
# ╭────┬────┬────╮  ╭────┬────┬────╮
# │ ┏┓ │    │    │  │ 0  │ 1  │ 2  │
# ├────┼────┼────┤  ├────┼────┼────┤
# │ ┗┛ │ ╔╗ │ ╔╗ │  │ 3  │ 4  │ 5  │
# ├────┼────┼────┤  ├────┼────┼────┤
# │    │ ╚╝ │ ╚╝ │  │ 6  │ 7  │ 8  │
# ├────┼────┼────┤  ├────┼────┼────┤
# │    │    │    │  │ 9  │ 10 │ 11 │
# ╰────┴────┴────╯  ╰────┴────┴────╯
################################################################################
# first row
contentMatrix[0]="${PURPLE}${THICKTOP}"
contentMatrix[1]="${EMPTY}"
contentMatrix[2]="${EMPTY}"
# second row
contentMatrix[3]="${PURPLE}${THICKBOTTOM}"
contentMatrix[4]="${LIGHTPURPLE}${DOUBLETOP}"
contentMatrix[5]="${LIGHTPURPLE}${DOUBLETOP}"
# third row
contentMatrix[6]="${EMPTY}"
contentMatrix[7]="${LIGHTPURPLE}${DOUBLEBOTTOM}"
contentMatrix[8]="${LIGHTPURPLE}${DOUBLEBOTTOM}"
# fourth row
contentMatrix[9]="${EMPTY}"
contentMatrix[10]="${EMPTY}"
contentMatrix[11]="${EMPTY}"


# add to steps
frames+=("${contentMatrix[*]}")

################################################################################
# frame 3
# ╭────┬────┬────╮  ╭────┬────┬────╮
# │    │ ┏┓ │    │  │ 0  │ 1  │ 2  │
# ├────┼────┼────┤  ├────┼────┼────┤
# │ ╔╗ │ ┗┛ │ ╔╗ │  │ 3  │ 4  │ 5  │
# ├────┼────┼────┤  ├────┼────┼────┤
# │ ╚╝ │    │ ╚╝ │  │ 6  │ 7  │ 8  │
# ├────┼────┼────┤  ├────┼────┼────┤
# │    │    │    │  │ 9  │ 10 │ 11 │
# ╰────┴────┴────╯  ╰────┴────┴────╯
################################################################################
# first row
contentMatrix[0]="${EMPTY}"
contentMatrix[1]="${PURPLE}${THICKTOP}"
contentMatrix[2]="${EMPTY}"
# second row
contentMatrix[3]="${LIGHTPURPLE}${DOUBLETOP}"
contentMatrix[4]="${PURPLE}${THICKBOTTOM}"
contentMatrix[5]="${LIGHTPURPLE}${DOUBLETOP}"
# third row
contentMatrix[6]="${LIGHTPURPLE}${DOUBLEBOTTOM}"
contentMatrix[7]="${EMPTY}"
contentMatrix[8]="${LIGHTPURPLE}${DOUBLEBOTTOM}"
# fourth row
contentMatrix[9]="${EMPTY}"
contentMatrix[10]="${EMPTY}"
contentMatrix[11]="${EMPTY}"


# add to steps
frames+=("${contentMatrix[*]}")

################################################################################
# frame 4
# ╭────┬────┬────╮  ╭────┬────┬────╮
#1│    │    │ ┏┓ │  │ 0  │ 1  │ 2  │
# ├────┼────┼────┤  ├────┼────┼────┤
#2│    │ ╔╗ │ ┗┛ │  │ 3  │ 4  │ 5  │
# ├────┼────┼────┤  ├────┼────┼────┤
#3│ ╔╗ │ ╚╝ │    │  │ 6  │ 7  │ 8  │
# ├────┼────┼────┤  ├────┼────┼────┤
#4│ ╚╝ │    │    │  │ 9  │ 10 │ 11 │
# ╰────┴────┴────╯  ╰────┴────┴────╯
################################################################################
# first row
contentMatrix[0]="${EMPTY}"
contentMatrix[1]="${EMPTY}"
contentMatrix[2]="${PURPLE}${THICKTOP}"
# second row
contentMatrix[3]="${EMPTY}"
contentMatrix[4]="${LIGHTPURPLE}${DOUBLETOP}"
contentMatrix[5]="${PURPLE}${THICKBOTTOM}"
# third row
contentMatrix[6]="${LIGHTPURPLE}${DOUBLETOP}"
contentMatrix[7]="${LIGHTPURPLE}${DOUBLEBOTTOM}"
contentMatrix[8]="${EMPTY}"
# fourth row
contentMatrix[9]="${LIGHTPURPLE}${DOUBLEBOTTOM}"
contentMatrix[10]="${EMPTY}"
contentMatrix[11]="${EMPTY}"


# add to steps
frames+=("${contentMatrix[*]}")


################################################################################
# frame 5
# ╭────┬────┬────╮  ╭────┬────┬────╮
#1│    │    │    │  │ 0  │ 1  │ 2  │
# ├────┼────┼────┤  ├────┼────┼────┤
#2│ ╔╗ │    │ ╔╗ │  │ 3  │ 4  │ 5  │
# ├────┼────┼────┤  ├────┼────┼────┤
#3│ ╚╝ │ ╔╗ │ ╚╝ │  │ 6  │ 7  │ 8  │
# ├────┼────┼────┤  ├────┼────┼────┤
#4│    │ ╚╝ │    │  │ 9  │ 10 │ 11 │
# ╰────┴────┴────╯  ╰────┴────┴────╯
################################################################################
# first row
contentMatrix[0]="${EMPTY}"
contentMatrix[1]="${EMPTY}"
contentMatrix[2]="${EMPTY}"
# second row
contentMatrix[3]="${LIGHTPURPLE}${DOUBLETOP}"
contentMatrix[4]="${EMPTY}"
contentMatrix[5]="${LIGHTPURPLE}${DOUBLETOP}"
# third row
contentMatrix[6]="${LIGHTPURPLE}${DOUBLEBOTTOM}"
contentMatrix[7]="${LIGHTPURPLE}${DOUBLETOP}"
contentMatrix[8]="${LIGHTPURPLE}${DOUBLEBOTTOM}"
# fourth row
contentMatrix[9]="${EMPTY}"
contentMatrix[10]="${LIGHTPURPLE}${DOUBLEBOTTOM}"
contentMatrix[11]="${EMPTY}"


# add to steps
frames+=("${contentMatrix[*]}")

################################################################################
# frame 6
# ╭────┬────┬────╮  ╭────┬────┬────╮
# │    │    │    │  │ 0  │ 1  │ 2  │
# ├────┼────┼────┤  ├────┼────┼────┤
# │ ╔╗ │ ╔╗ │    │  │ 3  │ 4  │ 5  │
# ├────┼────┼────┤  ├────┼────┼────┤
# │ ╚╝ │ ╚╝ │ ╔╗ │  │ 6  │ 7  │ 8  │
# ├────┼────┼────┤  ├────┼────┼────┤
# │    │    │ ╚╝ │  │ 9  │ 10 │ 11 │
# ╰────┴────┴────╯  ╰────┴────┴────╯
################################################################################
# first row
contentMatrix[0]="${EMPTY}"
contentMatrix[1]="${EMPTY}"
contentMatrix[2]="${EMPTY}"
# second row
contentMatrix[3]="${LIGHTPURPLE}${DOUBLETOP}"
contentMatrix[4]="${LIGHTPURPLE}${DOUBLETOP}"
contentMatrix[5]="${EMPTY}"
# third row
contentMatrix[6]="${LIGHTPURPLE}${DOUBLEBOTTOM}"
contentMatrix[7]="${LIGHTPURPLE}${DOUBLEBOTTOM}"
contentMatrix[8]="${LIGHTPURPLE}${DOUBLETOP}"
# fourth row
contentMatrix[9]="${EMPTY}"
contentMatrix[10]="${EMPTY}"
contentMatrix[11]="${LIGHTPURPLE}${DOUBLEBOTTOM}"


# add to steps
frames+=("${contentMatrix[*]}")

################################################################################
# frame 7
# ╭────┬────┬────╮  ╭────┬────┬────╮
# │    │    │    │  │ 0  │ 1  │ 2  │
# ├────┼────┼────┤  ├────┼────┼────┤
# │ ╔╗ │ ╔╗ │ ╔╗ │  │ 3  │ 4  │ 5  │
# ├────┼────┼────┤  ├────┼────┼────┤
# │ ╚╝ │ ╚╝ │ ╚╝ │  │ 6  │ 7  │ 8  │
# ├────┼────┼────┤  ├────┼────┼────┤
# │    │    │    │  │ 9  │ 10 │ 11 │
# ╰────┴────┴────╯  ╰────┴────┴────╯
################################################################################
# first row
contentMatrix[0]="${EMPTY}"
contentMatrix[1]="${EMPTY}"
contentMatrix[2]="${EMPTY}"
# second row
contentMatrix[3]="${LIGHTPURPLE}${DOUBLETOP}"
contentMatrix[4]="${LIGHTPURPLE}${DOUBLETOP}"
contentMatrix[5]="${LIGHTPURPLE}${DOUBLETOP}"
# third row
contentMatrix[6]="${LIGHTPURPLE}${DOUBLEBOTTOM}"
contentMatrix[7]="${LIGHTPURPLE}${DOUBLEBOTTOM}"
contentMatrix[8]="${LIGHTPURPLE}${DOUBLEBOTTOM}"
# fourth row
contentMatrix[9]="${EMPTY}"
contentMatrix[10]="${EMPTY}"
contentMatrix[11]="${EMPTY}"


# add to steps
frames+=("${contentMatrix[*]}")


################################################################################
# frame x
# ╭────┬────┬────╮  ╭────┬────┬────╮
# │    │    │    │  │ 0  │ 1  │ 2  │
# ├────┼────┼────┤  ├────┼────┼────┤
# │    │    │    │  │ 3  │ 4  │ 5  │
# ├────┼────┼────┤  ├────┼────┼────┤
# │    │    │    │  │ 6  │ 7  │ 8  │
# ├────┼────┼────┤  ├────┼────┼────┤
# │    │    │    │  │ 9  │ 10 │ 11 │
# ╰────┴────┴────╯  ╰────┴────┴────╯
################################################################################
# # first row
# contentMatrix[0]="${EMPTY}"
# contentMatrix[1]="${EMPTY}"
# contentMatrix[2]="${EMPTY}"
# # second row
# contentMatrix[3]="${EMPTY}"
# contentMatrix[4]="${EMPTY}"
# contentMatrix[5]="${EMPTY}"
# # third row
# contentMatrix[6]="${EMPTY}"
# contentMatrix[7]="${EMPTY}"
# contentMatrix[8]="${EMPTY}"
# # fourth row
# contentMatrix[9]="${EMPTY}"
# contentMatrix[10]="${EMPTY}"
# contentMatrix[11]="${EMPTY}"
#
#
# # add to steps
# frames+=("${contentMatrix[*]}")
