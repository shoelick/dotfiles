#!/usr/bin/env bash

export PREFIX=$HOME/testhome

tests/linking/install.sh.expect


cd configs
for conf_file_path in $(find . -type f | sed "s|^\./||"); do
    if [ ! -L $PREFIX/$conf_file_path ]; then
        echo "No $conf_file_path link found"
        return 1
    fi
done
echo "TEST Linking works fine"
