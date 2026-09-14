#!/usr/bin/env bash
set -euo pipefail

IMAGE="${1:-output-ubuntu-lab/packer-ubuntu-lab}"
SSH_PORT="${SSH_PORT:-2222}"
WEB_PORT="${WEB_PORT:-8080}"

[ -f "$IMAGE" ] || { echo "Imagem não encontrada: $IMAGE"; exit 1; }

qemu-system-x86_64 \
  -name ubuntu-lab \
  -machine q35,accel=kvm \
  -cpu host \
  -smp 4 \
  -m 8192 \
  -drive if=virtio,file="${IMAGE}",format=qcow2 \
  -netdev user,id=net0,hostfwd=tcp::${SSH_PORT}-:22,hostfwd=tcp::${WEB_PORT}-:8080 \
  -device virtio-net-pci,netdev=net0 \
  -display none \
  -daemonize

cat <<EOF
✔ VM iniciada (headless).
  SSH:         ssh -p ${SSH_PORT} labuser@localhost
  code-server: http://localhost:${WEB_PORT}
  Parar:       pkill -f 'qemu-system-x86_64.*ubuntu-lab'
EOF