#!/bin/sh

SCRIPT_DIR=$(cd $(dirname $0); pwd)
REPO_ROOT_DIR=$(cd "${SCRIPT_DIR}/.."; pwd)
WORKSPACE_DIR="${REPO_ROOT_DIR}/workspace"

CONTAINER_NAME="my-workstation-env-container"

if podman container exists "${CONTAINER_NAME}"; then
	echo "${CONTAINER_NAME} already exists."
	exit 1
fi

mkdir -p "${WORKSPACE_DIR}"

podman run \
	-d \
	-v "${WORKSPACE_DIR}":/workspace:z,U \
	-w /workspace \
	--cap-add=SYS_PTRACE \
	--group-add=keep-groups \
	--mount=type=bind,src=/dev/bus/usb,dst=/dev/bus/usb,rw \
	--name "${CONTAINER_NAME}" \
	--net=host \
	--privileged \
	--security-opt label=disable \
	--security-opt seccomp=unconfined \
	--volume=/run/udev:/run/udev:ro \
	ubuntu:latest \
	tail -f /dev/null
