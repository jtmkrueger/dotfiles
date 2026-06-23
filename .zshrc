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
  # NOTE: don't name a local "path" — in zsh it's tied to $PATH, so a local
  # would wipe PATH for the duration of this function (breaks plugins that
  # probe for binaries while sourcing, e.g. zsh-system-clipboard).
  local dir="$1" url="$2" file="$3"
  local plugin_dir="$HOME/.zsh/plugins/$dir"
  [[ -d "$plugin_dir" ]] || git clone --depth 1 "$url" "$plugin_dir"
  source "$plugin_dir/$file"
}

# Early plugins: must load before the vi-mode bindkeys below, which bind
# widgets (history-substring-search-*, autosuggest-*) these plugins provide.
_load_plugin zsh-system-clipboard          https://github.com/kutsan/zsh-system-clipboard          zsh-system-clipboard.zsh
_load_plugin zsh-autosuggestions           https://github.com/zsh-users/zsh-autosuggestions        zsh-autosuggestions.zsh
_load_plugin zsh-syntax-highlighting       https://github.com/zsh-users/zsh-syntax-highlighting    zsh-syntax-highlighting.zsh
_load_plugin zsh-history-substring-search  https://github.com/zsh-users/zsh-history-substring-search zsh-history-substring-search.zsh


# START VI mode
bindkey -v
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
bindkey -M vicmd 'H' beginning-of-line
bindkey -M vicmd 'L' end-of-line
function zle-keymap-select zle-line-init {
    # RPS1="${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}"
    # RPS2=$RPS1
    zle reset-prompt
    case $KEYMAP in
        vicmd)      echo -ne '\e[1 q';;  # block cursor
        viins|main) echo -ne '\e[5 q';;  # line cursor
    esac

    zle reset-prompt
    zle -R
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
# brew install lsd
DISABLE_LS_COLORS="true" # so lsd can colorize
alias ls='lsd'
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
# eval "$($HOME/.homebrew/bin/brew shellenv)"
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

# fzf-tab: replaces the completion menu with an fzf picker. Uses the same
# _load_plugin helper as the plugins above, but must load here because it
# depends on compinit (just run) and the fzf binary. Skipped if fzf is absent.
if command -v fzf &>/dev/null; then
  _load_plugin fzf-tab https://github.com/Aloxaf/fzf-tab fzf-tab.plugin.zsh
fi

newline=$'\n'
pathpart="%{$bg[blue]%} %{$fg[black]%}%~ %{\$bg[\$(git_branch_color)]%}%{$fg[blue]%}%{$fg[black]%}"
gitpart="%{\$bg[\$(git_branch_color)]%}\$(git_branch_name) %{$reset_color%}%{\$fg[\$(git_branch_color)]%}"
secondline="${newline}%{$bg[green]%} %{$fg[black]%} %{$reset_color%}%{$fg[green]%} "
prompt="${pathpart} ${gitpart}${secondline}"
