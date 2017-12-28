#!/bin/bash


#imports
source BashKitLibrary.sh




# draw a simple line
emptyLine 3
line




# draw a thick line
emptyLine 3
thickLine



# draw top of box
emptyLine 3
drawTop
drawLineWith "DEMO" right
drawSeparator
drawLine
drawLineWith "TASKS" left
drawLine
printf "\e[38;5;240m│\e[39m"
drawBetween "foo" "bar"
printf "\e[38;5;240m│\e[39m"
drawLine
drawBottom
emptyLine 3
