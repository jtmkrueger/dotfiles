export CLICOLOR=1
export GREP_OPTIONS="--color"
export LSCOLORS=gxfxcxdxbxegedabagacad
PS1='\n\[\e[0;34m\]\w \[\e[m\]\[\e[0;33m\]\[\e[3m\]$(parse_git_branch)\[\e[0m\]\[\e[m\] \[\e[1;32m\] \n\[\e[1;35m\] \[\e[m\]\[\e[0;32m\]> \[\e[m\]'
set -o vi

export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin:$PATH"
export PATH="$HOME/.homebrew/opt/openssl/bin:$PATH"
export PATH="$HOME/.homebrew/opt/openssl@1.1/bin:$PATH"
export PATH="$HOME/.homebrew/opt/make/libexec/gnubin:$PATH"
# export PATH=$PATH:/Users/jk/Library/Python/3.10/bin
# export PATH="/opt/homebrew/opt/python/libexec/bin:$PATH"
# custom homebrew path
export PATH="$HOME/.homebrew/bin:$PATH"
# export LDFLAGS="-L$HOME/.homebrew/opt/openssl@1.1/lib"
# export CPPFLAGS="-I$HOME/.homebrew/opt/openssl@1.1/include"

# if nvim command then set alias vim=nvim
if command -v nvim &> /dev/null
then
  alias vim=nvim
fi
if command -v lsd &> /dev/null
then
  # brew install lsd
  DISABLE_LS_COLORS="true" # so lsd can colorize
  alias ls=lsd
fi
if command -v bat &> /dev/null
then
  # brew install bat
  alias cat=bat
fi

# dbash <name of pod>
dbash() {
  docker exec -it $1 /bin/bash
}

# kbash <name of pod>
kbash() {
  kubectl exec --stdin --tty $1 -- /bin/bash
}

#color and git branch
parse_git_branch() {  
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_comp
# place this after nvm initialization!
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

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
