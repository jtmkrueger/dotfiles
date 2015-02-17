# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="agnoster"
DEFAULT_USER="jkrueger"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(vi-mode git zsh-history-substring-search autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH=".rbenv/shims:/usr/local/bin:/usr/local/share/npm/bin:/usr/local/var/rbenv/shims:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/opt/X11/bin"
# export MANPATH="/usr/local/man:$MANPATH"

export AUTOSUGGESTION_HIGHLIGHT_COLOR='fg=14'
zle-line-init() {
    zle autosuggest-start
}
zle -N zle-line-init
bindkey '^f' vi-forward-word

export TERM=xterm-256color
# You may need to manually set your language environment
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

# list all tmux sessions, and if there's none, don't show an error
tmux list-sessions 2> /dev/null

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
