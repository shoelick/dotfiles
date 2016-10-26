#!/bin/bash
###############################################################################
# install.sh
# This script handles installation of shoelick's dotfiles.
###############################################################################

source "util.sh"
DEBUG=1

echo "Shoelick Dotfiles"
echo "Updated October '16"

# Install / verify core for this platform
SUPPORTED_OS="Darwin"
THIS_OS=`uname`

if ! containsElement "${THIS_OS}" "${SUPPORTED_OS[@]}"  ;
then 
    echo "$THIS_OS not supported."
fi

# Get directory of repo
export DOTFILES_REPO_DIR="$( \cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export DOTFILES_DIR="$HOME/.dotfiles"


#######################################
# Configure dotfiles core setup
# Provides definition for:
# INSTALLER_CMD 
#######################################

echo "Detected $THIS_OS. Lucky for you, $THIS_OS is supported."
source "$DOTFILES_REPO_DIR/core/${THIS_OS}.sh"

## Set up .dotfiles directory
# The dotfiles directory is this repository and NOT a link to something else.

# @todo add warning if there already exists a backup in the dotfiles dir

# If the repo is not the final location and the final location exists
if [ "$DOTFILES_REPO_DIR" = "$DOTFILES_DIR" ] && [ -d "$DOTFILES_DIR"  ]; then
    # Move existing dotfiles dir to a backup dir
    # A link will not be moved
    cd "$HOME"
    mv -rv "$HOME/.dotfiles" "$DOTFILES_REPO_DIR/dotfiles.backup"
    cd "$HOME/.dotfiles"
fi

# Move repo to final destination
mv -v "$DOTFILES_REPO_DIR" "$DOTFILES_DIR"
export DOTFILES_BACKUP="$DOTFILES_DIR/dotfiles.backup"

## Configure git

# @todo set up .gitconfig?

# Perform update on dotfiles repo and submodules
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
PACKAGES="zsh neovim"

# Source each installation script.
for PKG in $PACKAGES; do 
    PKG_CONFIG="${DOTFILES_DIR}/packages/${PKG}/config"
    source "./packages/${PKG}/${PKG}.sh"
    # Source package install script
    # All should include definitions for:
    # Install, Configure
   
    Install
    if [[ $? -eq 0 ]]; then
        Configure
    else 
        echo "ERROR: Installation of $PKG failed."
    fi
    unset -f Install Configure
done    
