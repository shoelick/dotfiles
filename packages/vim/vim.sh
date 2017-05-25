#!/bin/bash
###############################################################################
# vim.sh
# 
###############################################################################

#
# This function installs vim using INSTALLER_CMD defined
# in the context this function is called.
# @depends INSTALLER_CMD Command used to install packages on this platform
# 
# @param none
# @return 0 on success, error code on fail
#
Install () {

    $INSTALLER_CMD vim    
    return $?
} 

#
# This function configures vim using defined DOTFILES_DIR in the
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

    InstallFiles "${PKG_DIR}/.vimrc" "${HOME}"
    return $?
}


# 
# This function provides a means to update vim. 
# @depends UPDATE_CMD Command to update a package on this platform
# Optional
#
Update() {

    echo "Updating for vim is not implemented."
}

#
# This function provides a means to uninstall vim.
# @depends UNINSTALL_CMD Uninstall command for this package
# Optional
#
Uninstall() {

    echo "Uninstallation for vim is not implemented."
}
