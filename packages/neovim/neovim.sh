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
# @depends PKG_CONFIG Directory of configuration files to be linked from $HOME
# @param none
# @return 0 on success, error code on fail
#
Configure () {

    echo "What's that? You want vim?" 
    sleep 2
    echo "Vim is for losers. Have neovim."

    BUNDLE_DIR=${HOME}/.config/nvim/bundle

    # If .config/nvim exists and is not already a link
    if [ -d "${HOME}/.config/nvim" ]; then
        # Back it up
        mv -fv ${HOME}/.config/nvim ${DOTFILES_BACKUP}/.config 
    fi

    # Link config files
    mkdir -p ${HOME}/.config/nvim/
    ln -sfv "${PKG_CONFIG}/config/nvim/vundle.vim" ~/.config/nvim/
    ln -sfv "${PKG_CONFIG}/config/nvim/init.vim" ~/.config/nvim/

    # Install Vundle
    mkdir -p "${BUNDLE_DIR}"
    git clone https://github.com/VundleVim/Vundle.vim.git "${BUNDLE_DIR}/vundle" 

    # Set up vundle
    nvim +PluginInstall +qall 

    cd "${BUNDLE_DIR}/YouCompleteMe"
    ./install.py

    return 0
}


