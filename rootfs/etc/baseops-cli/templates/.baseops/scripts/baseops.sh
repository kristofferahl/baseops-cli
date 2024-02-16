#!/usr/bin/env bash

set -euo pipefail

baseops_login() {
  echo "Ensuring we are logged in with docker..."
  docker login
}

baseops_architecture() {
  local arch="${BASEOPS_FORCE_ARCH:-}"
  if [[ -z "${arch}" ]]; then
    arch="$(uname -m)"
    case "${arch:-}" in
      x86_64) arch='amd64' ;;
    esac
  fi
  echo "${arch:?'Architecture not set'}"
}

baseops_build() {
  baseops_login "$@"

  # make we are using the builder
  if ! docker buildx use mpb-baseops &>/dev/null; then
    echo "Setting up buildx builder..."
    docker buildx create --use --platform "${BASEOPS_IMAGE_PLATFORMS:?}" --name mpb-baseops
    docker buildx inspect --bootstrap
  fi

  echo "Building docker image ${BASEOPS_IMAGE_REGISTRY}/${BASEOPS_IMAGE_NAME:?}:${BASEOPS_IMAGE_TAG:?} (${BASEOPS_IMAGE_PLATFORMS:?})..."

  local architecture

  # building image for each platform
  for platform in ${BASEOPS_IMAGE_PLATFORMS//,/ }; do
    architecture="${platform/linux\//}"
    docker buildx build --load --platform "${platform:?}" -t "${BASEOPS_IMAGE_REGISTRY}/${BASEOPS_IMAGE_NAME:?}:${BASEOPS_IMAGE_TAG:?}-${architecture:?}" --file .baseops/Dockerfile .baseops/
  done

  # instruct user on how to use the image
  architecture="$(baseops_architecture)"
  echo
  echo "INFO: To test the image locally, run \"export BASEOPS_FORCE_ARCH=${architecture:?}\""
  export BASEOPS_FORCE_ARCH=${architecture:?}
}

baseops_publish() {
  baseops_login "$@"

  # make we are using the builder
  if ! docker buildx use mpb-baseops &>/dev/null; then
    echo "Setting up buildx builder..."
    docker buildx create --use --platform "${BASEOPS_IMAGE_PLATFORMS:?}" --name mpb-baseops
    docker buildx inspect --bootstrap
  fi

  echo "Publishing docker image ${BASEOPS_IMAGE_REGISTRY}/${BASEOPS_IMAGE_NAME:?}:${BASEOPS_IMAGE_TAG:?} (${BASEOPS_IMAGE_PLATFORMS:?})..."

  # publish multi-arch image
  docker buildx build --push --platform "${BASEOPS_IMAGE_PLATFORMS:?}" -t "${BASEOPS_IMAGE_REGISTRY}/${BASEOPS_IMAGE_NAME:?}:${BASEOPS_IMAGE_TAG:?}" --file .baseops/Dockerfile .baseops/

  # publish for each platform
  for platform in ${BASEOPS_IMAGE_PLATFORMS//,/ }; do
    architecture="${platform/linux\//}"
    docker buildx build --push --platform "${platform:?}" -t "${BASEOPS_IMAGE_REGISTRY}/${BASEOPS_IMAGE_NAME:?}:${BASEOPS_IMAGE_TAG:?}-${architecture:?}" --file .baseops/Dockerfile .baseops/
  done

  # pulling to make sure we have the latest image after publish
  docker pull "${BASEOPS_IMAGE_REGISTRY}/${BASEOPS_IMAGE_NAME:?}:${BASEOPS_IMAGE_TAG:?}"
}
