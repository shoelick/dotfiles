# Shoeface's DotFiles

## Intro

The purpose of this dotfiles repository is create multi-platform, easily-deployable, and easily extensible dotfiles framework.

Poke around the various config files to see the tweaks. See the wiki for details what is supported and on extending. Pull requests welcome.

Loosely based on [Serubin's Dotfiles](https://github.com/Serubin/dotfiles) 

## Installation

Clone and run:

    git clone --recursive https://github.com/shoelick/dotfiles.git && cd dotfiles && ./shoefiles install default

This will automatically move the installation to `$HOME/.dotfiles`, backup any existing dotfiles setups into the new `$HOME/.dotfiles/dotfiles.back`, and symlink actual configuration dotfiles to their respective counterparts from this repository. I make no guarentees, but shoefiles has been made to be non-destructive unless it asks first.

## OS Support
* OS X (via Homebrew)
* Debian (Coming soon)
* Arch (Coming soon)

<!---
The install script takes care of all the pre-requists excluding git, , lsb-release, and sudo. However this only works with OSX, Arch,  Debian, and Ubuntu (for the moment). 

For all *linux* distributions
*The script will not be able to detect your os without ```lsb-release```, make sure to install it*

In OS X the script will install brew and all needed components. 

## What does this set up do?
This setup creates a clean bash envirnment with several other applications. Below is each application created and the features added. Of course I encourage you to look through the files to get a better picture of what this will set up for you.

#### Bash
*   Aliases (listed in bash/.alias)
*   Custom PS1 prompt with git integration
*   Functions to make life easy (listed in bash/.function) 

#### git
* Global ignore for mac os x
* Git Aliases (listed in packages/cli/git/config/.gitconfig)

#### Vim
* "Smart" features
* Shortcuts
* Line numbers
* Intelligent ignores
* lightline
* YouCompleteMe
* NerdTree
* Presistent undo
* Various completion packages
-->
