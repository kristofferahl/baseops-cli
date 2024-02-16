#!/usr/bin/env bash

baseops_init() {
  # initiliaze baseops here...
  DOCKER_RUN_ARGS+=(
    -v "/${PWD:?}:/work"
    -v "/${HOME:?}/.ssh/:/root/.ssh/"
    -v "//var/run/docker.sock:/var/run/docker.sock"
    -e TERM
    -e COLORTERM
    -e NO_LOGO
    --pull missing)
}
