#!/bin/bash
###############################################################################
# zsh.sh
# 
###############################################################################

#
# This function installs zsh using INSTALLER_CMD defined
# in the context this function is called.
# @depends INSTALLER_CMD Command used to install packages on this platform
# 
# @param none
# @return 0 on success, error code on fail
#
Install () {
    echo "Setting you up with zsh..."
    $INSTALLER_CMD zsh    
    return $?
} 

#
# This function configures zsh using defined DOTFILES_DIR in the
# context this function is called. In addition to linking any config files 
# sourced in the home directory to source files configured in DOTFILES_DIR,
# this function should configure any plugins.
# @depends DOTFILES_BACKUP Storage location for any existing dotfiles
# @depends PKG_CONFIG Directory of configuration files to be linked from $HOME
#
# @param none
# @return 0 on success, error code on fail
#
Configure () {

    echo "Bring in the colors and -- Oh my zsh!"

    # Install .zshrc
    InstallFiles "$PKG_CONFIG/.zshrc" "$HOME"

    # Back up existing oh-my-zsh install
    if [ -d "${HOME}/.oh-my-zsh" ]; then
        # Back it up
        mv -fv "${HOME}/.oh-my-zsh" ${DOTFILES_BACKUP}
    fi

    # Install oh-my-zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    
    # Perfom modification to agnoster theme
    # Changes PS1 to show up to 3 directories up from pwd
    sed -i "s/blue black '%~'/blue black '%3~'/g" "${HOME}/.oh-my-zsh/themes/agnoster.zsh-theme"

    return $?
}


