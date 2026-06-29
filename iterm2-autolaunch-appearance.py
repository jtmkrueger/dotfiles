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


# iTerm2 spawns this script from the GUI/launchd environment, whose PATH is the
# bare /usr/bin:/bin:/usr/sbin:/sbin — it does NOT include Homebrew's bin dir.
# So a bare `tmux` (installed at /opt/homebrew/bin on Apple Silicon, /usr/local/bin
# on Intel) is not found, and the tmux re-source silently fails while nvim still
# updates (pkill lives in /usr/bin). Prepend the Homebrew bins so `tmux` resolves
# regardless of how the script was launched.
_PATH_PREFIX = 'export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"; '


def reapply(theme: str) -> None:
    flag = "--dark" if "dark" in theme else "--light"
    # NOTE: tmux's source-file uses open(2) and CANNOT read /dev/fd/N process
    # substitution paths on macOS (it returns exit 2). So we write the helper
    # output to a real temp file, source that, then remove it — the same
    # canonical pattern used by .tmux.conf. `|| true` so a missing tmux server
    # (no sessions) is not an error; stderr is left visible for the iTerm2
    # script console so a real failure (e.g. tmux still not found) is debuggable.
    tmux_cmd = (
        f"f=$(mktemp -t tmux-appearance) && "
        f"~/Code/dotfiles/tmux-appearance.sh {flag} > \"$f\" && "
        f"tmux source-file \"$f\"; rm -f \"$f\""
    )
    subprocess.run(["bash", "-c", f"{_PATH_PREFIX}{{ {tmux_cmd}; }} || true"], check=False)
    # nvim: nudge every running instance to re-read appearance (Task 3 autocmd).
    subprocess.run(["bash", "-c", f"{_PATH_PREFIX}pkill -USR1 -x nvim || true"], check=False)


async def main(connection):
    async with iterm2.VariableMonitor(
        connection, iterm2.VariableScopes.APP, "effectiveTheme", None
    ) as mon:
        while True:
            theme = await mon.async_get()  # e.g. "dark high-contrast" / "light"
            reapply(theme)


iterm2.run_forever(main)
