#!/usr/bin/env bash
set -euo pipefail

VM_NAME="${VM_NAME:-ubuntu-lab-multiflora}"
IMAGE="${1:-outputs/${VM_NAME}}"
SSH_PORT="${SSH_PORT:-2222}"
WEB_PORT="${WEB_PORT:-8080}"

[ -f "$IMAGE" ] || { echo "Imagem não encontrada: $IMAGE"; exit 1; }

qemu-system-x86_64 \
  -name "${VM_NAME}" \
  -machine q35,accel=kvm \
  -cpu host \
  -smp 4 \
  -m 8192 \
  -drive if=virtio,file="${IMAGE}.qcow2",format=qcow2 \
  -netdev tap,id=net0,ifname=tap0,script=no,downscript=no,hostfwd=tcp::${SSH_PORT}-:22,hostfwd=tcp::${WEB_PORT}-:8080 \
  -device virtio-net-pci,netdev=net0 \
  -display none \
  -daemonize

cat <<EOF
✔ VM iniciada (headless).
  SSH:         ssh -p ${SSH_PORT} labuser@localhost
  code-server: http://localhost:${WEB_PORT}
  Parar:       pkill -f "qemu-system-x86_64.*${VM_NAME}"
EOF