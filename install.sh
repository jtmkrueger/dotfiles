#!/bin/bash
#
# this script can be triggered to run via devcontainer up:
# devcontainer up --mount 'type=bind,source=$HOME/.config/coc,target=/root/.config/coc' --mount 'type=bind,source=$HOME/.config/github-copilot,target=/root/.config/github-copilot' --dotfiles-repository https://github.com/jtmkrueger/dotfiles --remove-existing-container

set -e

echo "Symlink dotfiles"
# symlink the neovim config
mkdir -p ~/.config/nvim
ln -s ~/dotfiles/.vimrc ~/.config/nvim/init.vim
ln -s ~/dotfiles/coc-settings.json ~/.config/nvim/coc-settings.json

# install some bonus ruby gems
gem install rails_best_practices reek brakeman debride

echo "Install neovim dependencies and less"
# installing neovim & dependencies via apt
# currently trying to exclude netcat xclip
apt update -y && apt install -y ripgrep lua5.3 python3-pip ninja-build gettext cmake unzip curl build-essential less

# create a .pryrc file and turn off the pager
echo "Pry.config.pager = 'less'" > ~/.pryrc

echo "Install neovim"
cd
git clone --depth 1 --branch stable --single-branch https://github.com/neovim/neovim.git
cd neovim
make CMAKE_BUILD_TYPE=RelWithDebInfo
make install

echo "Install vim-plug and plugins"
# Install vim-plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

