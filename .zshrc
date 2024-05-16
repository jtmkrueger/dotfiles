# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH_DISABLE_COMPFIX="true"

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh
export PYTHON_CONFIGURE_OPTS="--enable-framework"
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

ZSH_THEME="powerlevel10k/powerlevel10k"

DISABLE_AUTO_TITLE="true"

fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src
plugins=(git bundler zsh-system-clipboard zsh-autosuggestions zsh-syntax-highlighting history-substring-search)

export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin:$PATH"

alias vim=nvim
# brew install lsd
DISABLE_LS_COLORS="true" # so lsd can colorize
alias ls='lsd'
alias cat='bat'
alias pretty_log="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset) %C(bold cyan)(committed: %cD)%C(reset) %C(auto)%d%C(reset)%n''          %C(white)%s%C(reset)%n''          %C(dim white)- %an <%ae> %C(reset) %C(dim white)(committer: %cn <%ce>)%C(reset)'"
alias dcvim="devcontainer up --remove-existing-container --mount 'type=bind,source=$HOME/.config/nvim,target=/root/.config/nvim' --additional-features '{\"ghcr.io/devcontainers-contrib/features/neovim:1\": {}}'"

source $ZSH/oh-my-zsh.sh

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=9'


export VISUAL="code -w -n"
export EDITOR="code -w -n"

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

# catch completion and linting gems up.
function rubyup() {
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
  solargraph bundle
  bundle exec yard gems
}

# https://github.com/jtmkrueger/bobafett
function bobafett() {
  echo "As you wish."
  for i in  $@; do
    if pgrep -f $i >/dev/null 2>&1;then
      pkill $i
    elif id -u $i >/dev/null 2>&1;then
      userdel $i
    fi
  done
}

function termcolors() {
  for i in {0..255}; do
    print -Pn "%K{$i} %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%8)):#7}:+$'\n'};
  done
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

# dbash <name of pod>
dbash() {
  docker exec -it $1 /bin/bash
}

# kbash <name of pod>
kbash() {
  kubectl exec --stdin --tty $1 -- /bin/bash
}

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# export PATH="$HOME/.homebrew/opt/node@16/bin:$PATH"


# configure homebrew
# eval "$($HOME/.homebrew/bin/brew shellenv)"
eval "$(/opt/homebrew/bin/brew shellenv)"

# chruby
# source $HOME/.homebrew/opt/chruby/share/chruby/chruby.sh
# source $HOME/.homebrew/opt/chruby/share/chruby/auto.sh
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

# allows easy running of docker compose
# export PATH=".git/safe/../../bin/docker-compose:.git/safe/../../bin:$PATH"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# pnpm
export PNPM_HOME="/Users/jkrueger/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
