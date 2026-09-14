#!/usr/bin/env bash
set -euxo pipefail

# Instalador oficial do Containerlab
sudo -E bash -c "$(curl -sL https://get.containerlab.dev)"

containerlab version