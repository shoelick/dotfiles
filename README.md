# Shoefiles

[![Build Status](https://travis-ci.com/shoelick/dotfiles.svg?branch=master)](https://travis-ci.com/shoelick/dotfiles)

## Intro

A collection of customizations for programs that use the ~/.configrc convention.

Essentially, configs is a psuedo-home directory. The scripts move the dotfiles
repo to `~/.dotfiles` create and link the corresponding files in the home
folder to whatever is in this folder.

For example:

    $HOME/.zshrc -> $HOME/.dotfiles/.zshrc
    $HOME/.config/nvim/init.vim -> $HOME/.dotfiles/.config/nvim/init.vim

The scripts back up conflicting existing files to ~/.dotfiles/dotfiles.backup.

## Features

* Non-destructive file installation methods -- any of your existing dotfiles will be backed up
* Git setup, including username, email, and a global .gitignore

*The disclaimer here is obvious; use at your own risk. I've done my best to make sure the installation is non-destructive.*

## Installation

Clone and run:

    git clone https://github.com/shoelick/dotfiles.git && cd dotfiles && ./install.sh

This will automatically move the installation to `$HOME/.dotfiles`, backup any existing dotfiles setups into the new `$HOME/.dotfiles/dotfiles.back`, and symlink actual configuration dotfiles to their respective counterparts from this repository.
