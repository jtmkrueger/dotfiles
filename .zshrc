# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

ZSH_THEME="avit"

DISABLE_AUTO_TITLE="true"

plugins=(git bundler zsh-completions zsh-autosuggestions zsh-syntax-highlighting history-substring-search)

export PATH="/usr/local/bin:/usr/bin:/.local/bin:/bin:/usr/sbin:/sbin::/.local/bin:$PATH"
# whatever :\ screw you aws
export PATH=~/.local/bin:$PATH

source $ZSH/oh-my-zsh.sh

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'

# START VI mode
bindkey -v
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
bindkey -M vicmd 'H' beginning-of-line
bindkey -M vicmd 'L' end-of-line
function zle-keymap-select zle-line-init {
    RPS1="${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}"
    RPS2=$RPS1
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

#rbenv path & init
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

