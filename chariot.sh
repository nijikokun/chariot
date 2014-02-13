#!/bin/bash

PROGRAM="chariot"
VERSION="0.1"

# Helpers

command_exists () {
  hash "$1" &> /dev/null;
}

node_module () {
  npm ${@:2}
  exit 0
}

bower_module () {
  bower ${@:2}
  exit 0
}

error () {
  echo "Error: $1";
  exit 0
}

display_help () {
  echo "$PROGRAM - package manager for both the web and node."
  echo " "
  echo "$PROGRAM [options] [arguments]"
  echo " "
  echo "options:"
  echo "-h, --help                show brief help"
  echo "-v, --version             show version"
  echo "web                       web package manager, use -h after this option for more info"
  echo "node                      node package manager, use -h after this option for more info"
  exit 0
}

# Arguments

while test $# -gt 0; do
  case "$1" in
    -h|--help)
      display_help
      ;;
    -v|--version)
      echo $VERSION
      ;;
    web)
      if command_exists bower; then
        bower_module $@
      elif command_exists npm; then
        npm install bower 2>/dev/null
        bower_module $@
      else
        error "npm has not been installed, please install npm to continue."
      fi
      ;;
    node)
      if command_exists npm; then
        node_module $@
      else
        error "npm has not been installed, please install npm to continue."
      fi
      ;;
    *)
      display_help
      ;;
  esac
done