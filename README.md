# Shoefiles

## Intro

A collection of customizations for programs that use the ~/.configrc convention.

## Features

* Framework for platform-specific initialization
* Non-destructive file installation methods -- any of your existing dotfiles will be backed up*
* Git setup, including username, email, and a global .gitignore

\* The disclaimer here is obvious; use at your own risk. I've done my best to make sure shoefiles are non-destructive.

## Installation

Clone and run:

    git clone --recursive https://github.com/shoelick/dotfiles.git && cd dotfiles && ./shoefiles install default

This will automatically move the installation to `$HOME/.dotfiles`, backup any existing dotfiles setups into the new `$HOME/.dotfiles/dotfiles.back`, and symlink actual configuration dotfiles to their respective counterparts from this repository. I make no guarentees, but shoefiles has been designed to be non-destructive unless it asks first.

