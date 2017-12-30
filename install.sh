#!/usr/bin/env bash
###############################################################################
# shoefiles (bash script)
# This script handles installation of shoelick's dotfiles.
###############################################################################

main() {

    echo "Shoelick Dotfiles"
    echo "Updated Dec '17"

    # Set to 1 for debugging argument parsing or earlier
    # Otherwise use -v for debugging
    export DEBUG_OUTPUT=0 

    export DOTFILES_REPO_DIR="$( \cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
    export DOTFILES_DIR="$HOME/.dotfiles"
    export DOTFILES_BACKUP=

    source "$DOTFILES_REPO_DIR/shoes/util.sh"
    source "$DOTFILES_REPO_DIR/shoes/shoes.conf"

    #
    # Move dotfiles to final location
    #
    ConfigureDotfilesDir
    RetVal=$?
    [ $RetVal -gt $ERROR_CODE_NONE ] && return $RetVal;

    # Install global gitignore
    #InstallFiles "$DOTFILES_DIR/shoes/.gitignore_global" "$HOME"

    #
    # Installation
    #

	InstallDir $DOTFILES_DIR/config $HOME

    #
    # Configuration
    #
    git config --global core.excludesfile ~/.gitignore_global

    #
    # Configure git
    #
    GIT_EMAIL="$(git config --global user.email)"
    Debug "Git email is: $GIT_EMAIL"
    if [ -z "$GIT_EMAIL" ]; then

        Debug "git email not set"
        EMAIL=$(EmailPrompt "Enter a valid email: ")
        Debug "Email is: $EMAIL"
        git config --global user.email $EMAIL
    fi

    GIT_USERNAME="$(git config --global user.name)"
    Debug "Git name is: $GIT_USERNAME"
    if [ -z "$GIT_USERNAME" ]; then

        Debug "git name not set"
        read -p "Git user name: " INPUT
        Debug "Using $INPUT for git user name"
        git config --global user.name $INPUT
    fi


    echo "Done."
    return $RetVal

} 

main $@
#cd .
