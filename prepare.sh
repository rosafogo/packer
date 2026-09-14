#!/usr/bin/env bash
set -euo pipefail

LAB_USER="${LAB_USER:-admin}"
LAB_PASSWORD="${LAB_PASSWORD:-1234}"
CS_PASSWORD="${CS_PASSWORD:-$LAB_PASSWORD}"

command -v openssl >/dev/null || { echo "openssl é necessário"; exit 1; }

HASH="$(openssl passwd -6 "$LAB_PASSWORD")"

sed -e "s|__USER__|${LAB_USER}|g" \
    -e "s@__PASS_HASH__@${HASH}@g" \
    http/user-data.tpl > http/user-data

cat > lab.auto.pkrvars.hcl <<EOF
ssh_username         = "${LAB_USER}"
ssh_password         = "${LAB_PASSWORD}"
code_server_password = "${CS_PASSWORD}"
EOF

echo "✔ http/user-data gerado (usuário: ${LAB_USER})"
echo "✔ lab.auto.pkrvars.hcl gerado"