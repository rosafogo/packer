#!/usr/bin/env bash
set -euxo pipefail

LAB_USER="${LAB_USER:-$(whoami)}"
CODE_SERVER_PASSWORD="${CODE_SERVER_PASSWORD:-labpass}"

curl -fsSL https://code-server.dev/install.sh | sh

mkdir -p "${HOME}/.config/code-server"
cat > "${HOME}/.config/code-server/config.yaml" <<EOF
bind-addr: 0.0.0.0:8080
auth: password
password: ${CODE_SERVER_PASSWORD}
cert: false
EOF
chmod 600 "${HOME}/.config/code-server/config.yaml"

sudo systemctl enable --now "code-server@${LAB_USER}"

code-server --install-extension redhat.vscode-yaml || true
code-server --install-extension ms-python.python || true
code-server --install-extension devcontainers || true