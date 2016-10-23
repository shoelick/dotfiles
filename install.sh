#!/bin/bash
###############################################################################
# install.sh
# This script handles installation of shoelick's dotfiles.
###############################################################################

source "util.sh"

# Install / verify core for this platform
SUPPORTED_OS="Darwin"
THIS_OS=`uname`

if ! containsElement "${THIS_OS}" "${SUPPORTED_OS[@]}"  ;
then 
    echo "$THIS_OS not supported."
fi

#######################################
# Configure dotfiles core setup
# Provides definition for:
# INSTALLER_CMD 
#######################################

source "core/${THIS_OS}.sh"

# Get directory of repo
export DOTFILES_REPO_DIR="$( \cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export DOTFILES_DIR="$HOME/.dotfiles"

## Set up .dotfiles directory

# If the repo is not the final location and the final location exists
if [[ ! "$DOTFILES_REPO_DIR" -eq "$DOTFILES_DIR" && -d "$DOTFILES_DIR"  ]]; then
    # Move existing dotfiles dir to a backup dir
    mv -v "$HOME/.dotfiles" "$DOTFILES_REPO_DIR/dotfiles.bak"
fi

# Move repo to final destination
mv -v "$DOTFILES_REPO_DIR" "$DOTFILES_DIR"

## Perform update on dotfiles repo and submodules
if [ -d "${DOTFILES_DIR}/.git" ]; then
    git --work-tree="${DOTFILES_DIR}" --git-dir="${DOTFILES_DIR}/.git" pull \
        --recurse-submodules=yes origin master
    git submodule init
    git submodule update
fi

#######################################
# Perform dotfiles toolbox setup
#######################################

# Package options
# Provided packages:
PACKAGES = "neovim"

# Source each installation script.
for PKG in PACKAGES; do 
    # Source package install script
    # All should include definitions for:
    # Install, Configure
    source "./packages/${PKG}/${PKG}.sh"
    
    Install
    if [[ $? -eq 0 ]]; then
        Configure
    else 
        echo "ERROR: Installation of $PKG failed."
    fi
    unset -f Install Configure
done    
