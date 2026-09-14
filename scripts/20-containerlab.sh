#!/usr/bin/env bash
set -euxo pipefail

sudo -E bash -c "$(curl -sL https://get.containerlab.dev)"

containerlab version