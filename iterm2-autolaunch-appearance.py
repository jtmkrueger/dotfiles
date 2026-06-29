#!/usr/bin/env python3
"""iTerm2 AutoLaunch script: on macOS appearance change, re-theme tmux + nvim.

Monitors the app-level `effectiveTheme` variable. On change:
  - re-sources tmux colors via ~/Code/dotfiles/tmux-appearance.sh
  - sends SIGUSR1 to running nvim processes (handled by an autocmd in init.lua)

Symlinked into ~/Library/Application Support/iTerm2/Scripts/AutoLaunch/.
Requires iTerm2 Python API enabled (Settings > General > Magic).
"""
import subprocess
import iterm2


def reapply(theme: str) -> None:
    flag = "--dark" if "dark" in theme else "--light"
    # NOTE: tmux's source-file uses open(2) and CANNOT read /dev/fd/N process
    # substitution paths on macOS (it returns exit 2). So we write the helper
    # output to a real temp file, source that, then remove it — the same
    # canonical pattern used by .tmux.conf. `|| true` so a missing tmux server
    # (no sessions) is not an error.
    tmux_cmd = (
        f"f=$(mktemp -t tmux-appearance) && "
        f"~/Code/dotfiles/tmux-appearance.sh {flag} > \"$f\" && "
        f"tmux source-file \"$f\"; rm -f \"$f\""
    )
    subprocess.run(["bash", "-c", f"{tmux_cmd} 2>/dev/null || true"], check=False)
    # nvim: nudge every running instance to re-read appearance (Task 3 autocmd).
    subprocess.run(["bash", "-c", "pkill -USR1 -x nvim || true"], check=False)


async def main(connection):
    async with iterm2.VariableMonitor(
        connection, iterm2.VariableScopes.APP, "effectiveTheme", None
    ) as mon:
        while True:
            theme = await mon.async_get()  # e.g. "dark high-contrast" / "light"
            reapply(theme)


iterm2.run_forever(main)
