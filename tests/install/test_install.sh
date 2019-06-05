#!/usr/bin/env bash

tests/install/install.sh.expect

if [ -e $HOME/.dotfiles ]; then
    echo "TEST Dotfiles installed to right directory"
    return 0
fi

return 1
