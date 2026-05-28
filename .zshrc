# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -z "$VIM" && -z "$NVIM" && $- == *i* ]]; then

  if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
  fi

  export ZSH_DISABLE_COMPFIX="true"

  # Path to your oh-my-zsh installation.
  export ZSH=~/.oh-my-zsh
  export PYTHON_CONFIGURE_OPTS="--enable-framework"
  export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

  # oracle instant client
  export OCI_DIR=$HOME/Downloads/instantclient_23_3


  ZSH_THEME="powerlevel10k/powerlevel10k"

  DISABLE_AUTO_TITLE="true"

  fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src
  plugins=(git bundler zsh-system-clipboard zsh-autosuggestions zsh-syntax-highlighting history-substring-search)

  source $ZSH/oh-my-zsh.sh

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
fi

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
  # gem install solargraph
  # gem update solargraph
  # gem install solargraph-rails
  # gem update solargraph-rails
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

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


# configure homebrew
# eval "$($HOME/.homebrew/bin/brew shellenv)"
eval "$(/opt/homebrew/bin/brew shellenv)"

# chruby
source /opt/homebrew/opt/chruby/share/chruby/chruby.sh
source /opt/homebrew/opt/chruby/share/chruby/auto.sh
chruby ruby-3.2.2

# set up pyenv
eval "$(pyenv init -)"

# environment variables if file exists
if [ -f ~/.zsh_env_vars ]; then
  source ~/.zsh_env_vars
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_comp
# place this after nvm initialization!
autoload -U add-zsh-hook
load-nvmrc() {
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$(nvm version)" ]; then
      nvm use
    fi
  elif [ -n "$(PWD=$OLDPWD nvm_find_nvmrc)" ] && [ "$(nvm version)" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# pnpm
export PNPM_HOME="/Users/jkrueger/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
export PATH="$HOME/.local/bin:$PATH"
