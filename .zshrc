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

plugins=(git bundler zsh-system-clipboard zsh-completions zsh-autosuggestions zsh-syntax-highlighting history-substring-search)

export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin:$PATH"
export PATH="/usr/local/opt/openssl/bin:$PATH"
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
export PATH="/opt/homebrew/opt/make/libexec/gnubin:$PATH"
# export PATH=$PATH:/Users/jk/Library/Python/3.10/bin
export PATH="/opt/homebrew/opt/python/libexec/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/openssl@1.1/lib"
export CPPFLAGS="-I/opt/homebrew/opt/openssl@1.1/include"


alias mvim=/Applications/MacVim.app/Contents/bin/mvim
alias vim=nvim
# brew install lsd
alias ls=lsd
alias cat=bat
# start cypress on the front end
alias ftest="CYPRESS_TEST_USER=seinfeld@aurorasolar.com CYPRESS_TEST_PASSWORD=elaine yarn cypress:open"
# TODO: get this actually working
# alias onepass="security find-generic-password -w -s 'Password_Name' -a sbillington"
# alias onelogin_aurora='eval "$(echo `onepass` | op signin --account aurorasolar.1password.com)"'
# eval "$(echo `onepass` | op signin --account aurorasolar.1password.com)"

source $ZSH/oh-my-zsh.sh

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=9'


export VISUAL=vim
export EDITOR="$VISUAL"

export CLOUDSDK_PYTHON="/opt/homebrew/bin/python3"

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

function zconsole() {
  docker-compose exec app rails c
}

function zlogs() {
  docker-compose exec app tail -f log/development.log
}

function zshell() {
  docker-compose exec app /bin/bash
}

# kbash <name of pod>
kbash() {
  kubectl exec --stdin --tty $1 -- /bin/bash
}

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PATH="/opt/homebrew/opt/node@16/bin:$PATH"


# configure homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# chruby
source /opt/homebrew/opt/chruby/share/chruby/chruby.sh
source /opt/homebrew/opt/chruby/share/chruby/auto.sh
chruby u ruby-3.2.2

# environment variables if file exists
if [ -f ~/.zsh_env_vars ]; then
  source ~/.zsh_env_vars
fi

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
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
