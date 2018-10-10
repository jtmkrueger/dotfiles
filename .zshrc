# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

ZSH_THEME="avit"

DISABLE_AUTO_TITLE="true"

plugins=(git bundler zsh-completions zsh-autosuggestions zsh-syntax-highlighting)

export PATH="/usr/local/bin:/usr/bin:/.local/bin:/bin:/usr/sbin:/sbin::/.local/bin:$PATH"
# whatever :\ screw you aws
export PATH=~/.local/bin:$PATH

source $ZSH/oh-my-zsh.sh

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=black'
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
# screenfetch

#rbenv path & init
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
# export NVM_DIR="/home/john/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# # TODO: fuck this shit
# nvm use --delete-prefix v8.6.0 --silent
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# elixir version management
# test -s "$HOME/.kiex/scripts/kiex" && source "$HOME/.kiex/scripts/kiex"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

