#!/usr/bin/env bash
set -Eeuo pipefail
IFS=$'\n\t'

setup_docker_group() {
    # https://docs.docker.com/install/linux/linux-postinstall/
    info "Creating docker group."
    groupadd -f docker > /dev/null 2>&1 || fatal "Failed to create docker group.\nFailing command: ${F[C]}groupadd -f docker"
    if [[ ${CI-} == true ]]; then
        notice "Skipping usermod in CI."
    else
        info "Adding ${DETECTED_UNAME} to docker group."
        usermod -aG docker "${DETECTED_UNAME}" > /dev/null 2>&1 || fatal "Failed to add ${DETECTED_UNAME} to docker group.\nFailing command: ${F[C]}usermod -aG docker \"${DETECTED_UNAME}\""
    fi
}

test_setup_docker_group() {
    run_script 'setup_docker_group'
}
