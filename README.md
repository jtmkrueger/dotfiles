dotfiles
========

A collection of my configurations since 2012.

## Devcontainers

The install.sh script is used to bootstrap a devcontainer by passing the  `--dotfiles-repository` flag. This will clone the dotfiles repository and run the install script.

```bash
devcontainer up --dotfiles-repository https://github.com/jtmkrueger/dotfiles --remove-existing-container
```


## Claude Code statusline

Symlink `statusline-command.sh` to `~/.claude/statusline-command.sh`:

```bash
ln -s ~/Code/dotfiles/statusline-command.sh ~/.claude/statusline-command.sh
```

Referenced by `~/.claude/settings.json` via the `statusLine` block.

## Set up Ghostty for operator

1. Install both Regular and Italic OperatorMono Nerd Fonts (Ghostty renders
   italics natively — no per-profile toggle needed).
2. Symlink the Ghostty config and custom dark theme into place:
   ```sh
   mkdir -p ~/.config/ghostty/themes
   ln -sf ~/Code/dotfiles/ghostty.conf ~/.config/ghostty/config
   ln -sf ~/Code/dotfiles/ghostty-themes/catppuccin-mocha-black \
          ~/.config/ghostty/themes/catppuccin-mocha-black
   ```

## Appearance: light/dark (Catppuccin)

The whole stack follows the macOS appearance — dark = Catppuccin Mocha (pure
black background), light = Catppuccin Latte — with no external script:

- **Ghostty** switches its own palette via `theme = light:Catppuccin
  Latte,dark:catppuccin-mocha-black` in `ghostty.conf`. The dark theme is a
  custom file (`ghostty-themes/catppuccin-mocha-black`) — Ghostty's built-in
  Catppuccin Mocha with `background = #000000` — so dark mode keeps a pure-black
  window. Light mode uses the built-in Latte.
- **nvim** self-detects via the terminal's OSC 11 / DEC mode 2031 (nvim ≥ 0.11);
  see `init.lua`. Terminal-agnostic, no signal.
- **tmux** re-themes live via its native `client-light-theme` /
  `client-dark-theme` hooks (tmux ≥ 3.6): it detects the theme flip Ghostty
  forwards and re-sources `tmux-appearance.sh`. `prefix r` re-detects on demand;
  startup detection runs on session create.

Toggle macOS System Settings → Appearance and Ghostty, tmux, and nvim all flip
together. Colors (active/inactive pane backgrounds, cursor, status) live in
`tmux-appearance.sh` and `.tmux.conf` and are terminal-independent.
