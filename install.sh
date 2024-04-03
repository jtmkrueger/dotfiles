#!/bin/bash

set -e

# symlink the neovim config
mkdir -p ~/.config/nvim
ln -s ~/dotfiles/.vimrc ~/.config/nvim/init.vim
ln -s ~/dotfiles/coc-settings.json ~/.config/nvim/coc-settings.json

# installing neovim & dependencies via apt
# apt update -y && apt install -y lua5.3 python3-pip

curl -LO https://github.com/neovim/neovim/releases/download/v0.7.2/nvim-linux64.deb
apt install ./nvim-linux64.deb

# Install vim-plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install plugins
nvim +PlugInstall +qall

