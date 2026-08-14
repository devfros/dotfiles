# dotfiles

Personal dotfiles for [Omarchy](https://omarchy.org) (Arch + Hyprland + Quickshell),
managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Install

```bash
git clone https://github.com/afros-rajabov/dotfiles ~/dotfiles
cd ~/dotfiles
bash install.sh
```

The installer:

1. Installs `stow` if missing.
2. Backs up any conflicting real files (`.bak.<timestamp>`), then removes them.
3. Symlinks each package into `~` via stow.
4. Downloads the voxtype multilingual Whisper model (English + Russian).

Re-run anytime to re-apply after changing branches or adding packages. To apply a
single package manually:

```bash
cd ~/dotfiles && stow <package>
```

## Packages

| Package | Target | Notes |
|---------|--------|-------|
| `hypr/` | `~/.config/hypr/` | Lua configs: keybindings, input (us+ru, Alt+Shift), look & feel, monitors, window rules |
| `omarchy/` | `~/.config/omarchy/` | Quickshell bar config (`shell.json`), custom logo widget, workspaces plugin |
| `tmux/` | `~/.config/tmux/` | TPM + plugins (catppuccin, sessionx, resurrect, continuum, yank, navigator) |
| `voxtype/` | `~/.config/voxtype/` | Dictation config: Whisper `base` multilingual, auto language |
| `linux-nvim/` | `~/.config/nvim/` | LazyVim configuration |
| `fish/` | `~/.config/fish/` | Fish shell config |
| `ghostty/` | `~/.config/ghostty/` | Ghostty terminal + cursor shaders |
| `kitty/` | `~/.config/kitty/` | Kitty terminal config |
| `starship/` | `~/.config/starship.toml` | Starship prompt |
| `yazi/` | `~/.config/yazi/` | File manager + flavors |
| `python/` | `~/pyproject.toml`, `~/ruff.toml`, `~/pyrightconfig.json` | Ruff / Pyright configs |
| `zshrc/` | `~/.zshrc` | Zsh config (fish is primary shell) |
| `waybar/` | `~/.config/waybar/` | **Obsolete** — left for reference after the Omarchy 4 Quickshell migration |

## Notes

- **Voxtype model** is not committed (large binary). The installer downloads it;
  see `install.sh`. Model: `~/.local/share/voxtype/models/ggml-base.bin`.
- **Bar layout**: workspaces center, clock/weather/indicators left, system tray right.
- **Keybindings**: dictation `SUPER + I`, Telegram `SUPER + SHIFT + T`.
- **Keyboard**: `us,ru`, switch with `Shift + Alt`.
- **Window rules**: browsers → workspace 9, Telegram → workspace 7.
