#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
OUTPUT_FILE="${REPO_ROOT}/config/nvim/.luarc.json"

if ! command -v nvim >/dev/null 2>&1; then
  echo "Error: nvim not found in PATH." >&2
  exit 1
fi

VIMRUNTIME="$(
  nvim --headless -u NONE -i NONE +'lua io.write(vim.env.VIMRUNTIME)' +qa
)"

RUNTIME_LUA="${VIMRUNTIME}/lua"

# Prefer stable Homebrew-style path if current runtime is under Cellar.
if [[ "${VIMRUNTIME}" =~ ^(/opt/homebrew|/usr/local)/Cellar/neovim/[^/]+/share/nvim/runtime$ ]]; then
  BREW_PREFIX="${BASH_REMATCH[1]}"
  STABLE_RUNTIME_LUA="${BREW_PREFIX}/share/nvim/runtime/lua"
  if [[ -d "${STABLE_RUNTIME_LUA}" ]]; then
    RUNTIME_LUA="${STABLE_RUNTIME_LUA}"
  fi
fi

if [[ ! -d "${RUNTIME_LUA}" ]]; then
  echo "Error: resolved Neovim runtime path does not exist: ${RUNTIME_LUA}" >&2
  exit 1
fi

cat > "${OUTPUT_FILE}" <<EOF
{
  "runtime": { "version": "LuaJIT" },
  "workspace": {
    "checkThirdParty": false,
    "library": ["${RUNTIME_LUA}"]
  }
}
EOF

echo "Wrote ${OUTPUT_FILE} using runtime ${RUNTIME_LUA}"
