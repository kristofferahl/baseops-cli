#!/usr/bin/env bash

logo() {
  export BANNER='oppenheimer'
  [[ "${NO_LOGO:-false}" == 'true' || "${QUIET:-false}" == 'true' ]] && return
  echo
  gum style --foreground 10 "# I am ${BANNER:?}!"
  gum style --foreground 10 "# Based on baseops-cli ${BASEOPS_CLI_VERSION:?}"
}

init() {
  # Put your initialization code here
  logo "$@"
}

init "$@"
