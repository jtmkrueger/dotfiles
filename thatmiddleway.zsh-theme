local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

local user_host='%{$terminfo[bold]$fg[green]%}%n@%m%{$reset_color%}'
local current_dir='%{$fg[cyan]%} %~%{$reset_color%}'
local rvm_ruby=''
if which rvm-prompt &> /dev/null; then
  rvm_ruby='%{$terminfo[bold]$fg[white]%}$(rvm-prompt i v g)%{$reset_color%}'
else
  if which rbenv &> /dev/null; then
    rvm_ruby='%{$terminfo[bold]$fg[green]%}($(rbenv version | sed -e "s/ (set.*$//"))%{$reset_color%}'
  fi
fi
local git_branch='$(git_prompt_info)%{$reset_color%}'
local svn_branch='$(svn_prompt_info)%{$reset_color%}'

PROMPT="${current_dir} ${git_branch} <${rvm_ruby}>%{$fg[blue]%}%t%{$reset_color%}
-> "
RPS1="${return_code}"

ZSH_THEME_GIT_PROMPT_PREFIX="(%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%})"

ZSH_THEME_SVN_PROMPT_PREFIX="("
ZSH_THEME_SVN_PROMPT_SUFFIX=")"
ZSH_THEME_SVN_PROMPT_DIRTY="%{$fg[red]%} ✘ %{$reset_color%}"
ZSH_THEME_SVN_PROMPT_CLEAN=" "
