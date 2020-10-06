export ZSH_DISABLE_COMPFIX="true"
# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh
export PYTHON_CONFIGURE_OPTS="--enable-framework"

# install: git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
ZSH_THEME="powerlevel10k/powerlevel10k"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(status dir dir_writable vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()
POWERLEVEL9K_MODE='nerdfont-complete'
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
POWERLEVEL9K_SHOW_CHANGESET=true
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
# POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="\ufc96 "
POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR=''
POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR=''
POWERLEVEL9K_STATUS_ERROR_BACKGROUND='yellow'
POWERLEVEL9K_STATUS_ERROR_FOREGROUND='black'
POWERLEVEL9K_STATUS_OK_BACKGROUND='black'
POWERLEVEL9K_DIR_HOME_BACKGROUND='blue'
POWERLEVEL9K_DIR_HOME_FOREGROUND='black'
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND='blue'
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND='black'
POWERLEVEL9K_VCS_CLEAN_FOREGROUND='green'
POWERLEVEL9K_VCS_CLEAN_BACKGROUND=08
POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND='yellow'
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND=08
POWERLEVEL9K_VCS_MODIFIED_FOREGROUND='red'
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND=08

DISABLE_AUTO_TITLE="true"

plugins=(git bundler zsh-system-clipboard zsh-completions zsh-autosuggestions zsh-syntax-highlighting history-substring-search)

export PATH="/usr/local/bin:/usr/bin:/.local/bin:/bin:/usr/sbin:/sbin::/.local/bin:$PATH"
# whatever :\ screw you aws
export PATH=~/.local/bin:$PATH
# go stuff
export GOPATH=$HOME/.go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
# rust stuff
export PATH=$PATH:$HOME/.cargo/env
export PATH="/usr/local/opt/openssl/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/openssl/lib"
export CPPFLAGS="-I/usr/local/opt/openssl/include"

alias mvim=/Applications/MacVim.app/Contents/bin/mvim

source $ZSH/oh-my-zsh.sh

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=9'


export VISUAL=vim
export EDITOR="$VISUAL"

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
  gem install solargraph
  gem update solargraph
  gem install reek
  gem update reek
  gem install rails_best_practices
  gem update rails_best_practices
  gem install rubocop
  gem update rubocop
  gem install brakeman
  gem update brakeman
  solargraph bundle
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


# chruby
# https://medium.com/@heidar/switching-from-rbenv-to-postmodern-s-ruby-install-and-chruby-f0daa24b36e6
source /usr/local/opt/chruby/share/chruby/chruby.sh
source /usr/local/opt/chruby/share/chruby/auto.sh

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
