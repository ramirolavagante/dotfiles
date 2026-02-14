#!/usr/bin/env bash
# Run after darwin-rebuild (or after home-manager switch) to install/update
# Doom Emacs core and your Doom config. Uses SSH (run in your shell so keys work). Idempotent.

set -e

CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
DOOM_CORE="${CONFIG_HOME}/emacs"
DOOM_CONFIG="${CONFIG_HOME}/doom"
DOOM_CONFIG_REPO="git@github.com:rodelrod/doom-emacs.git"
DOOM_CORE_REPO="git@github.com:doomemacs/doomemacs.git"

echo "==> Doom Emacs post-install"

# Doom config (your private config repo)
echo "Checking Doom config at ${DOOM_CONFIG}..."
if [[ ! -d "${DOOM_CONFIG}/.git" ]]; then
  echo "Cloning Doom config..."
  git clone "$DOOM_CONFIG_REPO" "$DOOM_CONFIG"
else
  echo "Updating Doom config..."
  git -C "$DOOM_CONFIG" remote set-url origin "$DOOM_CONFIG_REPO"
  git -C "$DOOM_CONFIG" pull --ff-only
fi

# Doom core
echo "Checking Doom core at ${DOOM_CORE}..."
if [[ ! -d "${DOOM_CORE}/.git" ]]; then
  echo "Cloning Doom core..."
  git clone --depth 1 "$DOOM_CORE_REPO" "$DOOM_CORE"
  echo "Running initial Doom install..."
  "${DOOM_CORE}/bin/doom" install
else
  echo "Doom core already present."
fi

echo "==> Done. Run 'doom sync' when you change your config."
