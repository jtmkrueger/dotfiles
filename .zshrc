# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

ZSH_THEME="avit"

DISABLE_AUTO_TITLE="true"

plugins=(git bundler zsh-completions zsh-autosuggestions zsh-syntax-highlighting)

export PATH="/usr/local/bin:/opt/pkg/sbin:/opt/pkg/bin:/usr/bin:/.local/bin:/bin:/usr/sbin:/sbin:/Applications/Postgres.app/Contents/Versions/9.4/bin:/.local/bin:$PATH"
# whatever :\ screw you aws
export PATH=~/.local/bin:$PATH

source $ZSH/oh-my-zsh.sh

alias eclim="/Applications/Eclipse.app/Contents/Eclipse/eclimd"
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
alias ls='ls -ahGF --color=auto'

export AUTOSUGGESTION_HIGHLIGHT_STYLE='fg=14'
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

archey

#rbenv path & init
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
