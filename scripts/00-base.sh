#!/usr/bin/env bash
set -euxo pipefail

sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install -y \
  curl wget git htop jq net-tools \
  ca-certificates gnupg lsb-release \
  apt-transport-https qemu-guest-agent

sudo systemctl enable --now qemu-guest-agent