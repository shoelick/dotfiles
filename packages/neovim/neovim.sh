#!/bin/bash
###############################################################################
# neovim.sh
# 
###############################################################################

#
# This function installs neovim using INSTALLER_CMD defined
# in the context this function is called.
# 
# @param none
# @return 0 on success, error code on fail
#
Install () {

    INSTALLER_CMD neovim

    return $?
} 

#
# This function configures neovim using defined DOTFILES_DIR in the
# context this function is called. In addition to linking any config files 
# sourced in the home directory to source files configured in DOTFILES_DIR,
# this function should configure any plugins.
# @depends DOTFILES_DIR New configuration
# @depends DOTFILES_BACKUP Storage location for any existing dotfiles
# @depends PKG_DIR Directory of configuration files to be linked from $HOME
# @param none
# @return 0 on success, error code on fail
#
Configure () {

    echo "What's that? You want vim?" 
    sleep 2
    echo "Vim is for losers. Have neovim."

    # Install config file
    mkdir -p "$HOME/.config/nvim"
    InstallFiles "$PKG_DIR/nvim/init.vim" "$HOME/.config/nvim"

    # Link config files
    ln -sfv "${PKG_CONFIG}/config/nvim/vundle.vim" ~/.config/nvim/
    ln -sfv "${PKG_CONFIG}/config/nvim/init.vim" ~/.config/nvim/

    # Install and setup Vundle
    BUNDLE_DIR=${HOME}/.config/nvim/bundle
    mkdir -p "${BUNDLE_DIR}"
    git clone https://github.com/VundleVim/Vundle.vim.git "${BUNDLE_DIR}/vundle" 
    nvim +PluginInstall +qall 

    # Build YouCompleteMe
    cd "${BUNDLE_DIR}/YouCompleteMe"
    ./install.py

    return 0
}


