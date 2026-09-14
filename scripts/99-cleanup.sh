#!/usr/bin/env bash
set -euxo pipefail

sudo apt-get -y autoremove --purge
sudo apt-get -y clean
sudo rm -rf /var/lib/apt/lists/*
sudo rm -rf /tmp/* /var/tmp/*
sudo rm -f /var/log/*.log /var/log/*.gz
sudo rm -rf /var/log/installer

# Reseta o estado do cloud-init para a VM "estrear" limpa no primeiro boot
sudo cloud-init clean --logs --seed 2>/dev/null || true

# Opcional: zerar espaço livre para reduzir o tamanho do qcow2
sudo dd if=/dev/zero of=/EMPTY bs=1M || true; sudo rm -f /EMPTY

history -c || true