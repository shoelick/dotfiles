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
# @depends BACKUP_DIR Storage location for any existing dotfiles
# @depends PKG_DIR Directory of configuration files to be linked from $HOME
#
# @param none
# @return 0 on success, error code on fail
#
Configure () {

    # Install .zshrc
    InstallFiles "$PKG_DIR/.zshrc" "$HOME"

    # Install oh-my-zsh
    # Won't install if it detects a present installation
    # automatically sets zsh as default shell
    curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh
	# Remove line that drops into zsh shell as part of script
	sed -i '' 's/env zsh//' install.sh
    sh -c  install.sh
    rm install.sh

    # oh-my-zsh replaces any existing .zshrc, so put ours back
    [ -e "$HOME/.zshrc.pre-oh-my-zsh" ] && mv "$HOME/.zshrc.pre-oh-my-zsh" "$HOME/.zshrc"

    # Perfom modification to agnoster theme
    # Changes PS1 to show up to 3 directories up from pwd
    # The single '' after -i makes the command macOS-safe
    sed -i '' -e "s/blue black '%\~'/blue black '%3\~'/g" "${HOME}/.oh-my-zsh/themes/agnoster.zsh-theme" 2>/dev/null

    cd $DOFTILES_DIR

    # Download font for user and print directions to install
    # @todo automatically install somehow?
    #curl -O "http://media.nodnod.net/Inconsolata-dz.otf.zip"
    #echo "Downloaded zip with InconsolataDz font in $DOTFILES_DIR. Install as needed."

    echo "zsh configured. You may need to re-login to use it."

    return $?
}


