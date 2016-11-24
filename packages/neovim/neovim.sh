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


    if [ $PLATFORM != "Debian" ]; then
        $INSTALLER_CMD neovim
    else 
        # Debian requires manual build from source

        # ... only do it if we have to
        if ! which nvim > /dev/null; then
        
            # Handle dependencies
            sudo apt-get install libtool libtool-bin autoconf automake \ 
                cmake g++ pkg-config unzip

            # Install from source
            cd /tmp 
            git clone https://github.com/neovim/neovim.git neovim
            cd neovim

            make && sudo make install && cd ..
            rm -rf neovim

	else 
	    echo "ERROR: nvim already installed. Not Reinstalling." 
	    echo "Please first run 'shoefiles uninstall neovim' if you want to reinstall it."
        echo "Use 'shoefiles update neovim' to update automatically."

        fi
    fi

    # Arch requires python support to be installed separately
    if [ $PLATFORM == "Arch" ]; then
        $INSTALLER_CMD python-neovim python2-neovim
    fi

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
        echo "Looks like Vundle (or another vim plugin manager) is installed."
        echo "Not installing Vundle or plugins."
        echo "Please delete $BUNDLE_DIR and try again for fresh Vundle install."
    fi

# 
# This function provides a means to update neovim. 
# @depends UPDATE_CMD Command to update a package on this platform
# Optional
#
Update() {
    

}

#
# This function provides a means to uninstall neovim.
# @depends UNINSTALL_CMD Uninstall command for this package
# Optional
#
Install() {

    echo "Uninstallation for neovim is not implemented."
}
