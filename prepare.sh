#!/usr/bin/env bash
set -ex

.install_docker() {
    curl -fsSL https://get.docker.com | sh
    sudo usermod -aG docker $USER
    echo "> Log out and log back so that your group membership is re-evaluated."
}

# Check if docker exists
if ! [ -x "$(command -v docker)" ]; then
    .install_docker
fi

# Give docker the rights to access the X-Server
xhost +local:docker