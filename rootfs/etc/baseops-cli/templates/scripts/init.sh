#!/usr/bin/env bash

init_logo() {
  export BANNER='{{ .Env.CLI_BANNER }}'
  [[ "${NO_LOGO:-false}" == 'true' || "${QUIET:-false}" == 'true' ]] && return 0
  echo
  gum style --foreground 10 "# I am ${BANNER:?} {{ .Env.CLI_VERSION_VAR | strings.ToUpper }}!"
  gum style --foreground 10 "# Based on baseops-cli ${BASEOPS_CLI_VERSION:?}, running on Alpine ${BASEOPS_ALPINE_VERSION:?}"
}

init() {
  # Put your initialization code here
  init_logo "$@"
}

init "$@"
