#!/bin/sh

CONTAINER_NAME="my-workstation-env-container"

if ! podman container exists "${CONTAINER_NAME}"; then
	echo "${CONTAINER_NAME} doesn't exist."
	exit 1
fi

podman stop \
	"${CONTAINER_NAME}"

podman container rm \
	"${CONTAINER_NAME}"
