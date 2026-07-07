#!/usr/bin/env bash
# Emit tmux set-option commands for the current macOS appearance.
# dark = Catppuccin Mocha (current colors); light = Catppuccin Latte.
# Usage: tmux-appearance.sh [--dark|--light] [--apply]
#   no --dark/--light => detect via defaults
#   --apply => source the commands into the running tmux server directly,
#              instead of printing them to stdout. Used by the client-*-theme
#              hooks in .tmux.conf so no shell variable appears in the tmux
#              config (tmux expands $vars in stored set-hook bodies at parse
#              time, which silently blanks a temp-file path — see git history).

set -euo pipefail

mode=""
apply=""
for arg in "$@"; do
  case "$arg" in
    --dark)  mode="dark" ;;
    --light) mode="light" ;;
    --apply) apply="1" ;;
    *) echo "usage: $0 [--dark|--light] [--apply]" >&2; exit 2 ;;
  esac
done

if [ -z "$mode" ]; then
  if defaults read -g AppleInterfaceStyle 2>/dev/null | grep -qi dark; then
    mode="dark"
  else
    mode="light"
  fi
fi

if [ "$mode" = "dark" ]; then
  # Catppuccin Mocha — preserves existing values exactly.
  active_bg="#000000"
  inactive_bg="#1e1e2e"
  border_bg="#1e1e2e"
  pane_active_fg="green"
  status_bg="black"
  status_fg="white"
  status_left_fg="green"
  status_bell_bg="white"
else
  # Catppuccin Latte — active=base, inactive=crust.
  active_bg="#eff1f5"
  inactive_bg="#dce0e8"
  border_bg="#dce0e8"
  pane_active_fg="blue"
  status_bg="#dce0e8"
  status_fg="#4c4f69"
  status_left_fg="blue"
  status_bell_bg="magenta"
fi

commands=$(cat <<EOF
set -g window-active-style bg=${active_bg}
set -g window-style bg=${inactive_bg}
set -g pane-active-border-style bg=${border_bg},fg=${pane_active_fg}
set -g pane-border-style bg=${border_bg},fg=magenta
set -g status-style fg=${status_fg},bg=${status_bg}
set -g window-status-activity-style bg=${status_bg},fg=${status_fg},blink
set -g window-status-bell-style bg=${status_bell_bg},fg=${status_fg},blink
setw -g window-status-format '#{?window_activity_flag, #[fg=${status_fg} bg=${status_bg}]#[blink],#[fg=${status_fg} bg=${status_bg}]}#{?window_bell_flag,#[fg=${status_fg} bg=${status_bg}]#[blink],#[fg=${status_fg} bg=${status_bg}]}  #I-#W#{?window_zoomed_flag,,} #[bg=${status_bg}, fg=${status_fg}] '
setw -g window-status-current-format '#[bg=${status_bg}, fg=magenta] #[bg=magenta, fg=${status_bg}]#[bg=magenta, fg=${status_bg}] #I-#W#{?window_zoomed_flag,,} #[bg=${status_bg}, fg=magenta]'
set -g status-left '#[bg=${status_bg}, fg=${status_left_fg}, italics]  #S #[bg=${status_bg}, fg=${status_bg}, noitalics]#[bg=${status_bg}, fg=terminal] '
set -g status-right ''
EOF
)

if [ -n "$apply" ]; then
  # tmux source-file needs a real file (it uses open(2) and cannot read a
  # /dev/fd/N process-substitution path on macOS). Write to a temp file here in
  # bash — where $f is an ordinary shell variable tmux never parses — then
  # source it. This is why the client-*-theme hooks call `--apply` instead of
  # inlining the temp-file dance: an inline $f in a set-hook body gets expanded
  # (to empty) by tmux at parse time. `|| true` tolerates no running server.
  f=$(mktemp -t tmux-appearance)
  printf '%s\n' "$commands" > "$f"
  tmux source-file "$f" 2>/dev/null || true
  rm -f "$f"
else
  printf '%s\n' "$commands"
fi
