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

    $INSTALLER_CMD neovim

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

    # Link config files
    InstallFiles "${PKG_DIR}/vundle.vim" ${HOME}/.config/nvim/
    InstallFiles "${PKG_DIR}/init.vim" ${HOME}/.config/nvim/

    # Install and setup Vundle
    BUNDLE_DIR=${HOME}/.config/nvim/bundle
    if [ ! -e "$BUNDLE_DIR" ]; then
        mkdir -p "${BUNDLE_DIR}"
        git clone https://github.com/VundleVim/Vundle.vim.git "${BUNDLE_DIR}/vundle" 
        nvim +PluginInstall +qall 

        # Build YouCompleteMe
        cd "${BUNDLE_DIR}/YouCompleteMe"
        ./install.py
    else
        echo "Looks like Vundle (or another vim plugin manager is installed."
        echo "Not installing Vundle or plugins."
        echo "Please delete $BUNDLE_DIR and try again for fresh Vundle install."
    fi

    return 0
}


