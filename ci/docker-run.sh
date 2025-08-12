#!/bin/bash
# SPDX-License-Identifier: MIT
#
# create and run docker build env
# Usage: ci/docker-run.sh
#
set -e -u -o pipefail
CMDPATH="$(realpath "$(dirname "$0")")"
BASEDIR=${CMDPATH%/*}
PROJECT=elos_systemmonitoring

IMAGE="${PROJECT}"

echo "==> create docker image"
cd "${BASEDIR}/ci"
DOCKER_BUILDKIT=1 \
    docker build \
    --progress=plain \
    --build-arg UID="$(id -u)" --build-arg GID="$(id -g)" \
    --tag "${IMAGE}" .

echo "==> run $PROJECT build container"
docker run --rm -it --privileged \
    -v "${BASEDIR}:/base" -w /base "${IMAGE}" $@
