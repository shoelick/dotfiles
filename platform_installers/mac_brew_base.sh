#!/usr/bin/env sh

[ -z $(which brew) ] && echo "Install brew first" && exit;
brew install neovim ctags tmux python cmake
/usr/local/bin/pip3 install neovim

cd ~/.config/nvim/bundle/YouCompleteMe
./install.py

