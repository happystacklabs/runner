#!/bin/bash


#imports
source BashKitLibrary.sh
source helpers.sh




# vars
declare -a steps=(
  "Bump version"
  "Run build"
  "Run lib"
  "Run 200.html"
  "Deploy to Surge"
  "Deploy package to NPM"
)
currentVersion='0.0.0'




# run tests
runTests() {
  for i in "${steps[@]}"
  do
    printf "\e[38;5;240m│\e[39m"
    drawBetween "🕐  $i" " \e[38;5;105m[In progress]\e[39m"
    printf "\e[38;5;240m│\e[39m\n"
    drawLine
  done
}


run() {
  # run tests
  drawHeader
  drawTop
  drawLine
  runTests
  drawBottom
  emptyLine 2
  space 1
  printf "⚠️  Current version is \e[38;5;105m$currentVersion\e[39m"
  emptyLine 1
  drawTextInput "Bump version to"
  # drawTop
  # printf "\e[48;5;235m"
  # drawLineWith "Bumb version to: " "left"
  # printf "\e[0m"
  # drawBottom
  # emptyLine 3
}

run
