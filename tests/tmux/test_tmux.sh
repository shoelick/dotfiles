#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

source $DIR/../setup.sh
cd $DOTFILES_DIR
$DIR/tmux.expect

conf_file_path=~/.tmux.conf
if [ ! -L $conf_file_path ]; then
    echo "No tmux conf link found"
    return 1
else
    echo "TEST: tmux config confirmed"
fi

