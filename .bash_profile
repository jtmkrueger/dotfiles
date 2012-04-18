#node.js module
export NODE_PATH="/usr/local/lib/node"

#fix for postgresql
export PATH=/usr/local/bin:/usr/local/sbin:$PATH
#alias for sublime text 2
alias sublime='open -a "Sublime Text 2"'
#alias for chrome dev channel
alias chromedev='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --enable-extension-timeline-api &'
#alias for textmate
alias mate='open -a "TextMate"'
#alias for macvim
alias gvim='open -a "MacVim"'
#alias for dev tmux
alias dev='tmux -f ~/dev.conf attach'
#grc stuff
GRC=`which grc`
if [ "$TERM" != dumb ] && [ -n GRC ]
then
  alias colourify="$GRC -es --colour=auto"
  alias ping='colourify ping'
fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function

#color and git branch
parse_git_branch() {  
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
export CLICOLOR=1
export GREP_OPTIONS="--color"
export LSCOLORS=gxfxcxdxbxegedabagacad

PS1='\n\[\e[0;34m\]\w \[\e[m\]\[\e[0;33m\]$(parse_git_branch)\[\e[m\] \[\e[1;32m\]$(~/.rvm/bin/rvm-prompt)\[\e[m\] \n\[\e[1;35m\]\[\e[m\]\[\e[0;32m\]> \[\e[m\]'


[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
