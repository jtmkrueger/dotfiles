#!/bin/bash
#

set -e

# symlink the neovim config
ln -s init.vim ~/.config/nvim/init.vim
ln -s neo.vim ~/.config/nvim/neo.vim
ln -s coc-settings.json ~/.config/nvim/coc-settings.json

# This will bootstrap neovim by
# * installing neovim via apt
# * installing vim-plug
# * installing plugins
# Install neovim
apt update && apt install neovim

# Install vim-plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install plugins
nvim +PlugInstall +qall

