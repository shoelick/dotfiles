#!/usr/bin/env sh

[ -z $(which brew) ] && echo "Install brew first" && exit;
brew install neovim tmux python git
pip3 install --break-system-packages --user neovim

