#!/usr/bin/env bash
#
# Install and symlink dotfiles via GNU Stow.
#
# Usage:
#   bash install.sh
#
# Prerequisites:
#   - stow (installed automatically if missing, requires sudo for pacman)
#   - git

set -euo pipefail

REPO_URL="https://github.com/afros-rajabov/dotfiles"
REPO_NAME="dotfiles"

# ------------------------------------------------------------------ helpers

info() { printf '\033[32m✓\033[0m %s\n' "$*"; }
warn() { printf '\033[33m!\033[0m %s\n' "$*"; }
fail() { printf '\033[31m✗ %s\033[0m\n' "$*" >&2; exit 1; }

have() { command -v "$1" >/dev/null 2>&1; }

ensure_stow() {
  if have stow; then
    return 0
  fi

  if ! have pacman; then
    fail "stow is not installed and pacman is unavailable. Install stow first."
  fi

  warn "stow is not installed. Installing with pacman (may prompt for sudo)..."
  sudo pacman -S --noconfirm --needed stow || fail "failed to install stow"
}

# Back up an existing path if it is a real file/dir (not a symlink), then
# remove it so stow can place its symlink.
reset_path() {
  local path="$1"
  if [ -e "$path" ] && [ ! -L "$path" ]; then
    local backup="${path}.bak.$(date +%Y%m%d%H%M%S)"
    mv "$path" "$backup"
    info "backed up $path -> $backup"
  fi
}

# ------------------------------------------------------------------ main

ensure_stow

cd "$HOME"

if [ -d "$REPO_NAME" ]; then
  info "repository '$REPO_NAME' already exists, using it"
else
  info "cloning $REPO_URL"
  git clone "$REPO_URL" || fail "failed to clone repository"
fi

cd "$REPO_NAME"

info "removing old configs (backed up first)"
# These are stowed as symlinks; remove any real files/dirs that would collide.
reset_path "$HOME/.config/nvim"
reset_path "$HOME/.cache/nvim"
reset_path "$HOME/.local/share/nvim"
reset_path "$HOME/.config/starship.toml"
reset_path "$HOME/.config/alacritty/alacritty.toml"
reset_path "$HOME/.config/fish/config.fish"
reset_path "$HOME/.config/ghostty/config"
reset_path "$HOME/.config/kitty/kitty.conf"
reset_path "$HOME/.config/yazi"
reset_path "$HOME/.config/hypr"
reset_path "$HOME/.config/omarchy"
reset_path "$HOME/.config/voxtype"
reset_path "$HOME/.config/tmux/tmux.conf"
reset_path "$HOME/.config/herdr/config.toml"
reset_path "$HOME/.tmux.conf"
reset_path "$HOME/.zshrc"

info "symlinking with stow"
stow kitty
stow ghostty
stow fish
stow starship
stow tmux
stow herdr
stow yazi
stow linux-nvim
stow hypr
stow omarchy
stow voxtype
stow python
stow zshrc

info "downloading voxtype multilingual Whisper model (English + Russian)"
if have voxtype; then
  voxtype setup --download --model base || warn "voxtype model download failed; run: voxtype setup --download --model base"
else
  warn "voxtype not installed; skip model download. Install voxtype, then run: voxtype setup --download --model base"
fi

info "done. Restart your session (or Hyprland) to pick up changes."
