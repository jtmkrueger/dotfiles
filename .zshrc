export ZSH_DISABLE_COMPFIX="true"

export PYTHON_CONFIGURE_OPTS="--enable-framework"
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

# speed up db connections to AWS
export PGGSSENCMODE="disable";

# Plugins
#   plugins=(zsh-system-clipboard zsh-autosuggestions zsh-syntax-highlighting history-substring-search)

# Clone a plugin into ~/.zsh/plugins if missing, then source it.
# Usage: _load_plugin <dir> <repo-url> <file-to-source>
# Single source of truth for plugin loading. Most plugins load here, but a few
# (e.g. fzf-tab) must load later because they call this helper from their own spot.
_load_plugin() {
  local dir="$1" url="$2" file="$3"
  local plugin_dir="$HOME/.zsh/plugins/$dir"
  [[ -d "$plugin_dir" ]] || git clone --depth 1 "$url" "$plugin_dir"
  source "$plugin_dir/$file"
}

# Early plugins: must load before the vi-mode bindkeys below, which bind
# widgets (history-substring-search-*, autosuggest-*) these plugins provide.
_load_plugin zsh-system-clipboard https://github.com/kutsan/zsh-system-clipboard zsh-system-clipboard.zsh
_load_plugin zsh-autosuggestions https://github.com/zsh-users/zsh-autosuggestions zsh-autosuggestions.zsh
_load_plugin zsh-history-substring-search https://github.com/zsh-users/zsh-history-substring-search zsh-history-substring-search.zsh
# NOTE: zsh-syntax-highlighting is intentionally NOT loaded here. It wraps every
# zle widget that exists at source time, so it MUST be sourced last — after
# compinit and fzf-tab bind their widgets. It's loaded at the very end of this
# file. Sourcing it early leaves later widgets unwrapped and corrupts typing.


# START VI mode
bindkey -v
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
bindkey -M vicmd 'H' beginning-of-line
bindkey -M vicmd 'L' end-of-line
# Switch the cursor shape to match the vi keymap (block in normal, line in
# insert). Bound to both zle-keymap-select (fires on every mode change) and
# zle-line-init (fires once when a new prompt's line editor starts).
#
# NOTE: do NOT call `zle reset-prompt` here. The prompt doesn't render the vi
# mode (the RPS1 lines below are disabled), so there's nothing to redraw, and
# forcing a reset/redisplay on every line-init under tmux repaints the prompt
# multiple times and echoes typed characters into the stale copies.
function zle-keymap-select zle-line-init {
    # RPS1="${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}"
    # RPS2=$RPS1
    case $KEYMAP in
        vicmd)      echo -ne '\e[1 q';;  # block cursor
        viins|main) echo -ne '\e[5 q';;  # line cursor
    esac
}

function zle-line-finish
{
    echo -ne '\e[1 q'  # block cursor
}

zle -N zle-line-init
zle -N zle-line-finish
zle -N zle-keymap-select
export KEYTIMEOUT=1
# END VI mode

export DYLD_LIBRARY_PATH="/usr/local/opt/libyaml/lib:$DYLD_LIBRARY_PATH"

bindkey '^j' autosuggest-accept

alias vim=nvim
# brew install eza
# --git status shows automatically in long view (ls -l)
alias ls='eza --icons=always --group-directories-first'
alias cat='bat'
alias pretty_log="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset) %C(bold cyan)(committed: %cD)%C(reset) %C(auto)%d%C(reset)%n''          %C(white)%s%C(reset)%n''          %C(dim white)- %an <%ae> %C(reset) %C(dim white)(committer: %cn <%ce>)%C(reset)'"
alias dcvim="devcontainer up --remove-existing-container --mount 'type=bind,source=$HOME/.config/nvim,target=/root/.config/nvim' --additional-features '{\"ghcr.io/devcontainers-contrib/features/neovim:1\": {}}'"
alias claude='NODE_TLS_REJECT_UNAUTHORIZED=0 claude'
alias copilot='NODE_TLS_REJECT_UNAUTHORIZED=0 copilot'

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=9'

# -I: ignore case when searching
# -F: quit immediately when the entire file fits in one screen (in effect, mimic cat’s behavior)
# -R: enable colored output (for example, when piping to less from diff --color=always)
# -S: truncate long lines instead of wrapping them to the next line
# -X: don’t clear screen on exit
export LESS="IFRSX"

export EDITOR="vim"


# catch completion and linting gems up.
#
# If the project has a Gemfile.local, point BUNDLE_GEMFILE at it so we
# bundle against a local-only lockfile instead of the committed one.
# Useful when the committed Gemfile.lock omits arm64-darwin and bundling
# would otherwise try to compile native gems from source.
#
# To set one up:
#   echo 'eval_gemfile "Gemfile"' > Gemfile.local
#   # Hide from git. In a monorepo subproject, .git is a file; the real
#   # exclude is at `$(git rev-parse --git-common-dir)/info/exclude`.
#   echo Gemfile.local      >> .git/info/exclude   # or .gitignore
#   echo Gemfile.local.lock >> .git/info/exclude
#   export BUNDLE_GEMFILE=$PWD/Gemfile.local
#   bundle lock --add-platform arm64-darwin
#   gem uninstall nokogiri -aIx                    # nuke broken source builds
#   bundle install
function rubyup() {
  # walk up looking for Gemfile.local so this works from any subdir.
  # local -x keeps BUNDLE_GEMFILE scoped to this function so it doesn't
  # stick around in the shell after rubyup returns.
  local dir="$PWD"
  while [[ "$dir" != "/" && ! -f "$dir/Gemfile.local" ]]; do
    dir="${dir:h}"
  done
  if [[ -f "$dir/Gemfile.local" ]]; then
    local -x BUNDLE_GEMFILE="$dir/Gemfile.local"
    echo "rubyup: using $BUNDLE_GEMFILE"
  fi

  bundle
  gem install ruby-lsp
  gem install reek
  gem update reek
  gem install debride
  gem update debride
  gem install rails_best_practices
  gem update rails_best_practices
  gem install rubocop
  gem update rubocop
  gem install brakeman
  gem update brakeman
  # Herb ERB linter is an npm package (@herb-tools/linter -> `herb-lint`),
  # NOT a Ruby gem. The Ruby `herb` gem is only the parser.
  npm install -g @herb-tools/linter
}

# shows the auth thing and puts the auth you want in the paste buffer
# pass the auth you want as an argument in the paste buffer
# dependency: https://github.com/pcarrier/gauth
# EX: mfa AWS
# TODO: set this up to work with bitwarden
function mfa() {
  gauth
  gauth | grep $1 | awk '{$1=$2=$4=""; print $0}' | sed 's/ //g' | pbcopy
  echo "copied $1 OTP to clipboard"
}

# dbash <name of container>
dbash() {
  docker exec -it $1 /bin/bash
}

# kbash <name of pod>
kbash() {
  kubectl exec --stdin --tty $1 -- /bin/bash
}

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# fzf shell integration (keybindings + completion). Needed by fzf-tab below.
if command -v fzf &>/dev/null; then
  source <(fzf --zsh)
elif [ -f ~/.fzf.zsh ]; then
  source ~/.fzf.zsh
fi


# configure homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# chruby
source /opt/homebrew/opt/chruby/share/chruby/chruby.sh
source /opt/homebrew/opt/chruby/share/chruby/auto.sh
chruby ruby-3.2.2

# set up pyenv
# --no-rehash skips the slow shim rebuild at startup; do it in the background instead
eval "$(pyenv init - --no-rehash)"
(pyenv rehash &) 2>/dev/null

# environment variables if file exists
if [ -f ~/.zsh_env_vars ]; then
  source ~/.zsh_env_vars
fi

# fnm (replaces nvm): https://github.com/Schniz/fnm
# --use-on-cd: auto-switch node version when cd-ing into a dir with .nvmrc
# recursive: search parent dirs for .nvmrc, fall back to default if none
eval "$(fnm env --use-on-cd --version-file-strategy=recursive --shell zsh)"

# pnpm
export PNPM_HOME="/Users/jkrueger/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
export PATH="$HOME/.local/bin:$PATH"

## PROMPT stuff
# Find and set branch name var if in git repository.
function git_branch_color {
  local color="blue" # assume no branch
  local branch=$(git symbolic-ref HEAD 2> /dev/null | awk 'BEGIN{FS="/"} {print $NF}')

  if [ -n "$branch" ]; then
    local rs="$(git status --porcelain -b)"
    if $(echo "$rs" | grep -v '^##' &> /dev/null); then # is dirty
      color="red"
    elif $(echo "$rs" | grep '^## .*diverged' &> /dev/null); then # has diverged
      color="redm"
    elif $(echo "$rs" | grep '^## .*behind' &> /dev/null); then # is behind
      color="yellow"
    elif $(echo "$rs" | grep '^## .*ahead' &> /dev/null); then # is ahead
      color="yellow"
    else # is clean
      color="green"
    fi
  fi

  echo -n $color
}
function git_branch_name()
{
  local branch=$(git symbolic-ref HEAD 2> /dev/null | awk 'BEGIN{FS="/"} {print $NF}')
  if [[ $branch == "" ]];
  then
    :
  else
    echo $branch
  fi
}

# Enable substitution in the prompt.
setopt prompt_subst

autoload -Uz compinit && compinit
autoload -U colors && colors
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# --- completion styles that fzf-tab relies on (safe to set before sourcing) ---
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
# NOTE: don't use escape sequences (like '%F{red}%d%f') here, fzf-tab will ignore them
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# force zsh not to show completion menu, which lets fzf-tab capture the unambiguous prefix
zstyle ':completion:*' menu no

# fzf-tab: replaces the completion menu with an fzf picker. Uses the same
# _load_plugin helper as the plugins above, but must load here because it
# depends on compinit (just run) and the fzf binary. Skipped if fzf is absent.
if command -v fzf &>/dev/null; then
  _load_plugin fzf-tab https://github.com/Aloxaf/fzf-tab fzf-tab.plugin.zsh

  # --- fzf-tab styles: must be set AFTER fzf-tab is sourced ---
  # render the picker in a centered tmux popup (falls back to inline outside tmux)
  zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
  # floor the popup size so short lists (e.g. `cd` with a few dirs) don't
  # collapse the list/preview into a tiny unusable box. width height (cols/rows),
  # capped at the window size by ftb-tmux-popup.
  zstyle ':fzf-tab:*' popup-min-size 80 15
  # previews in the popup, per completion type:
  # cd: directory contents (with file-type icons)
  zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --icons=always --color=always $realpath'
  # files (cat/editors/etc): syntax-highlighted contents, dir listing for dirs
  zstyle ':fzf-tab:complete:*:*' fzf-preview \
    '[[ -d $realpath ]] && eza -1 --icons=always --color=always $realpath || bat --color=always --style=numbers $realpath 2>/dev/null'
  # git checkout/branch refs: show the commit log for the selected ref
  zstyle ':fzf-tab:complete:git-checkout:*' fzf-preview \
    'git log --oneline --graph --color=always $word 2>/dev/null'
  # env vars (export/unset/$VAR): show the current value
  zstyle ':fzf-tab:complete:(-command-|export|unset):*' fzf-preview \
    'echo ${(P)word}'
  # kill/process: full process info for the selected PID (BSD ps, macOS)
  zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-preview \
    'ps -p $word -o pid,ppid,%cpu,%mem,command 2>/dev/null'
  zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-flags '--preview-window=down:4:wrap'
fi

newline=$'\n'
pathpart="%{$fg[blue]%}%~ %{\$fg[\$(git_branch_color)]%}"
gitpart="\$(git_branch_name) %{$reset_color%}"
secondline="${newline}%{$fg[green]%} %{$reset_color%} "
prompt="${pathpart} ${gitpart}${secondline}"

# Load zsh-syntax-highlighting LAST. It wraps every zle widget present at source
# time, so everything that binds widgets (the plugins above, compinit, fzf-tab,
# the vi-mode bindkeys) must already be loaded. Sourcing it any earlier leaves
# later widgets unwrapped and corrupts line editing (eaten/duplicated keys).
_load_plugin zsh-syntax-highlighting https://github.com/zsh-users/zsh-syntax-highlighting zsh-syntax-highlighting.zsh
