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
gem install rails_best_practices

echo "Install neovim dependencies"
# installing neovim & dependencies via apt
apt update -y && apt install -y ripgrep lua5.3 python3-pip ninja-build gettext cmake unzip curl build-essential

echo "Install neovim"
cd
git clone --depth 1 --single-branch https://github.com/neovim/neovim.git
cd neovim
git checkout stable
make CMAKE_BUILD_TYPE=RelWithDebInfo
make install

echo "Install vim-plug and plugins"
# Install vim-plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install plugins
nvim +PlugInstall +qa

