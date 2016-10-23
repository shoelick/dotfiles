#!/bin/bash
###############################################################################
# Darwin.sh
# This script handles installing the core packages for macOS.
# Must define INSTALLER_CMD
###############################################################################

# Verify brew is installed
which -s brew
if [[ $? != 0 ]] ; then
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# prepare brew
brew tap caskroom/cask
brew install brew-cask
brew tap homebrew/versions

# update brew
brew update
brew upgrade

apps=(
    cmake
    coreutils
    git
    gnu-sed --default-names
    grep --default-names
    htop-osx
    perl
    python
    wget
)

# Install all of the listed packages 
brew install ${apps[@]}

unset apps

# Provide installer cmd
export INSTALLER_CMD="brew install" 
