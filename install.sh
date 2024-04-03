#!/bin/bash
#
# this script can be triggered to run via devcontainer up:
# devcontainer up --dotfiles-repository https://github.com/jtmkrueger/dotfiles --remove-existing-container

set -e

# symlink the neovim config
mkdir -p ~/.config/nvim
ln -s ~/dotfiles/.vimrc ~/.config/nvim/init.vim
ln -s ~/dotfiles/coc-settings.json ~/.config/nvim/coc-settings.json

# installing neovim & dependencies via apt
apt update -y && apt install -y lua5.3 python3-pip ninja-build gettext cmake unzip curl build-essential

git clone --depth 1 https://github.com/neovim/neovim.git
cd neovim
git checkout stable
make CMAKE_BUILD_TYPE=RelWithDebInfo
make install

# curl -LO https://github.com/neovim/neovim/releases/download/v0.7.2/nvim-linux64.deb
# apt install ./nvim-linux64.deb

# Install vim-plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install plugins
nvim +PlugInstall +qall

