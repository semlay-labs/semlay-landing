#!/usr/bin/env bash
set -euo pipefail

NODE_VERSION="v22.14.0"
NODE_DIR="${HOME}/.local/node-${NODE_VERSION}-linux-x64"
export PATH="${NODE_DIR}/bin:${PATH}"

if [[ ! -x "${NODE_DIR}/bin/node" ]]; then
  echo "Installing Node ${NODE_VERSION} to ${NODE_DIR}..."
  mkdir -p "${HOME}/.local"
  tmp="$(mktemp)"
  curl -fsSL "https://nodejs.org/dist/${NODE_VERSION}/node-${NODE_VERSION}-linux-x64.tar.xz" -o "${tmp}"
  tar -xJf "${tmp}" -C "${HOME}/.local"
  rm -f "${tmp}"
fi

cd "$(dirname "$0")/.."
node -v
exec npm run dev -- "$@"
