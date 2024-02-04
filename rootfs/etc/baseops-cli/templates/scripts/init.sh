#!/usr/bin/env bash

banner() {
  export BANNER='{{ .Env.CLI_BANNER }}'
  echo
  echo "Welcome to ${BANNER:?}!"
}

init() {
  # Put your initialization code here
  banner "$@"
}

init "$@"
