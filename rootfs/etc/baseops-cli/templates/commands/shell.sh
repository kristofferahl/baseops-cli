#!/usr/bin/env bash

shell() {
  if [[ -z "${TERM}" || "${TERM}" == 'dumb' ]]; then
    echo "WARN: The shell command requires a terminal to be present!"
    exit 1
  fi
  SHLVL=0 # Reset the shell level
  /etc/baseops/scripts/boot
}
