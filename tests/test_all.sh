#!/usr/bin/env bash

export PREFIX=$HOME/testhome
mkdir -p $PREFIX

[ $(source tests/install/test_install.sh) -gt 0 ] && return 1
[ $(source tests/linking/test_linking.sh) -gt 0 ] && return 1

[ $(nvim +PluginInstall +qall) -gt 0 ] && return 1
