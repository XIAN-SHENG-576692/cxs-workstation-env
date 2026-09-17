#!/bin/sh

CONTAINER_NAME="my-workstation-env-container"

if ! podman container exists "${CONTAINER_NAME}"; then
	echo "${CONTAINER_NAME} doesn't exist."
	exit 1
fi

podman start \
	"${CONTAINER_NAME}"

podman exec \
	-it \
	"${CONTAINER_NAME}" \
	/bin/bash
