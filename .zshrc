# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

ZSH_THEME="avit"

DISABLE_AUTO_TITLE="true"

plugins=(git bundler zsh-completions zsh-autosuggestions zsh-syntax-highlighting)

export PATH="/usr/local/bin:/usr/bin:/.local/bin:/bin:/usr/sbin:/sbin::/.local/bin:$PATH"
# whatever :\ screw you aws
export PATH=~/.local/bin:$PATH

source $ZSH/oh-my-zsh.sh

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
bindkey '^f' vi-forward-word

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

# TODO: is https://github.com/KittyKatt/screenFetch/issues/573 fixed?
# until then use my fork
screenfetch-dev

#rbenv path & init
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

