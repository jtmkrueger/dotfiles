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

## Set up iterm for operator

1. Install both Regular and Italic OperatorMonoNerdFonts
2. Enable support for italic text
    * Preferences > Profiles > Text > Italic text allowed
3. Install xterm-256color-italic
    * tic xterm-256color-italic

## Appearance: light/dark (Catppuccin)

nvim and tmux follow the macOS appearance — dark = Catppuccin Mocha, light =
Catppuccin Latte. Detection uses `defaults read -g AppleInterfaceStyle`; both
detect at startup, and `prefix r` (tmux) re-detects on demand.

Live switching (auto-flip when you toggle macOS appearance) is driven by an
iTerm2 AutoLaunch script. To enable it:

1. Enable iTerm2's Python API: Settings → General → Magic → "Enable Python API".
   The first time, iTerm2 downloads its Python runtime (`iterm2env`) — this only
   happens on the next iTerm2 launch, so a restart is required (step 3).
2. Symlink the script into iTerm2's AutoLaunch folder:
   ```sh
   mkdir -p ~/Library/Application\ Support/iTerm2/Scripts/AutoLaunch
   ln -sf ~/Code/dotfiles/iterm2-autolaunch-appearance.py \
          ~/Library/Application\ Support/iTerm2/Scripts/AutoLaunch/appearance.py
   ```
3. Restart iTerm2.

AutoLaunch scripts load once at iTerm2 startup, so **after editing
`iterm2-autolaunch-appearance.py` you must restart iTerm2** (or restart the
script from the Scripts menu) for changes to take effect. The script runs from
iTerm2's launchd environment, whose `PATH` lacks Homebrew's bin dir — so it
prepends `/opt/homebrew/bin` and `/usr/local/bin` itself to find `tmux`. If the
tmux side ever stops switching, check the script console (Scripts → Manage →
Console) for errors.

Without iTerm2 (or with the API disabled) you still get correct colors at
startup/reload; only the automatic live switch is unavailable. When the
appearance can't be read, both default to light (macOS reports no
`AppleInterfaceStyle` key in light mode).
