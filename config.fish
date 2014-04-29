alias vim 'mvim -v'

set brew_rbenv "/usr/local/var/rbenv/shims"
# put homebrew and rbenv at the front of $PATH
set -gx PATH "/usr/local/bin:/usr/local/share/npm/bin:/usr/local/var/rbenv/shims" $PATH
set -gx RBENV_ROOT "/usr/local/var/rbenv"

set -gx VIMRUNTIME '/usr/local/Cellar/macvim/7.4-72/MacVim.app/Contents/Resources/vim/runtime'

# ORACLE garbage
set -gx DYLD_LIBRARY_PATH "/Applications/Oracle"
set -gx LD_LIBRARY_PATH "/Applications/Oracle"
set -gx SQLPATH "/Applications/Oracle"
set -gx TNS_ADMIN "/Applications/Oracle"
set -gx ORACLE_HOME "/Applications/Oracle"
set -gx NLS_LANG "AMERICAN_AMERICA.UTF8"
set -gx PATH $PATH:$DYLD_LIBRARY_PATH
set -gx RC_ARCHS i386
set -gx INSTANT_CLIENT_DIRECTORY "/Applications/Oracle"

# start prompt
set -xg fish_color_user magenta
set -xg fish_color_prompt blue
set -xg fish_color_pwd cyan

set -g __fish_git_prompt_show_informative_status 1
set -g __fish_git_prompt_hide_untrackedfiles 1

set -g __fish_git_prompt_color_branch yellow bold
set -g __fish_git_prompt_showupstream "informative"
set -g __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showupstream 'yes'

set -g __fish_git_prompt_char_upstream_ahead "↑"
set -g __fish_git_prompt_char_upstream_behind "↓"
set -g __fish_git_prompt_char_upstream_prefix ""
set -g __fish_git_prompt_char_stagedstate "●"
set -g __fish_git_prompt_char_dirtystate "Δ"
set -g __fish_git_prompt_char_stagedstate '→'
set -g __fish_git_prompt_char_stashstate '↩'
set -g __fish_git_prompt_char_untrackedfiles "…"
set -g __fish_git_prompt_char_conflictedstate "✖"
set -g __fish_git_prompt_char_cleanstate "✔"

set -g __fish_git_prompt_color_dirtystate blue
set -g __fish_git_prompt_color_stagedstate yellow
set -g __fish_git_prompt_color_invalidstate red
set -g __fish_git_prompt_color_untrackedfiles magenta
set -g __fish_git_prompt_color_cleanstate green

function fish_prompt --description 'Write out the prompt'
  echo
  set -l last_status $status

  # User
  set_color $fish_color_user
  echo -n (whoami)
  set_color normal

  echo -n ' '

  # PWD
  set_color $fish_color_pwd
  echo -n (pwd) # prompt_pwd for the shortened version
  set_color normal
  echo -n ' '

  printf '%s ' (__fish_git_prompt)
  echo

  set_color $fish_color_prompt
  if not test $last_status -eq 0
  set_color $fish_color_error
  end

  echo -n '➤ '
  set_color normal
end
# end prompt
# right prompt
function fish_right_prompt --description 'write out right prompt'
  echo -n (date)
end
# end right prompt
