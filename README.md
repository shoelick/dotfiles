# Shoefiles

## Intro

The purpose of this dotfiles repository is create multi-platform, easily-deployable, and easily extensible preferences framework.

Poke around the various config files to see my tweaks from the defaults. See the wiki for details what is supported and on extending. Pull requests welcome.

Loosely based on [Serubin's Dotfiles](https://github.com/Serubin/dotfiles).

## Features

* Framework for platform-specific initialization
* Framework for easily adding packages and support for defining package groups
* Non-destructive file installation methods -- any of your existing dotfiles will be backed up*
* Git setup, including username, email, and a global .gitignore

\* The disclaimer here is obvious; use at your own risk. I've done my best to make sure shoefiles are non-destructive.

## Installation

Clone and run:

    git clone --recursive https://github.com/shoelick/dotfiles.git && cd dotfiles && ./shoefiles install default

This will automatically move the installation to `$HOME/.dotfiles`, backup any existing dotfiles setups into the new `$HOME/.dotfiles/dotfiles.back`, and symlink actual configuration dotfiles to their respective counterparts from this repository. I make no guarentees, but shoefiles has been designed to be non-destructive unless it asks first.

## OS Support
* OS X (via Homebrew)
* Debian 
* Arch 

