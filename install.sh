#!/bin/bash

set -e

# symlink the neovim config
mkdir -p ~/.config/nvim
ln -s ~/dotfiles/.vimrc ~/.config/nvim/init.vim
ln -s ~/dotfiles/coc-settings.json ~/.config/nvim/coc-settings.json

# installing neovim dependencies via apt
apt update -y && apt install -y lua5.3 python3-pip

# download nvim appimage
curl -LO https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
chmod u+x nvim.appimage && ./nvim.appimage

# Install vim-plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install plugins
nvim +PlugInstall +qall

