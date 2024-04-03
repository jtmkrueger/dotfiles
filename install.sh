#!/bin/bash

set -e

# symlink the neovim config
mkdir -p ~/.config/nvim
ln -s ~/dotfiles/init.vim ~/.config/nvim/init.vim
ln -s ~/dotfiles/neo.vim ~/.config/nvim/neo.vim
ln -s ~/dotfiles/coc-settings.json ~/.config/nvim/coc-settings.json

# installing neovim via apt
apt update -y && apt install -y neovim

# Install vim-plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install plugins
nvim +PlugInstall +qall

