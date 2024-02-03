#!/usr/bin/env bash

export BANNER='{{ .Env.CLI_NAME }}'

shell() {
  SHLVL=0 # Reset the shell level
  /etc/baseops/scripts/boot
}
