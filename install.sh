#!/usr/bin/env bash
###############################################################################
# shoefiles (bash script)
# This script handles installation of shoelick's dotfiles.
###############################################################################

main() {

    echo "Shoelick Dotfiles"
    echo "Updated June '24"

    # Set to 1 for debugging argument parsing or earlier
    # Otherwise use -v for debugging
    export DEBUG_OUTPUT=0

    export DOTFILES_REPO_DIR="$( \cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
    export DOTFILES_DIR="$HOME/.dotfiles"
    export DOTFILES_BACKUP="$DOTFILES_DIR/backup"

    source "$DOTFILES_REPO_DIR/util.sh"

    AreArgsValid "$@"

    #
    # Move dotfiles to final location
    #
    ConfigureDotfilesDir || return $RetVal;

    #
    # Installation
    #

    [ -z $PREFIX ] && PREFIX=$HOME;

    # Try to install platform dependencies
    #export PLATFORM_INSTALLER="$DOTFILES_DIR/platform_installers/$(uname).sh";
    export PLATFORM_INSTALLER="$DOTFILES_DIR/platform_installers/penish.sh";
    if [ -f "$PLATFORM_INSTALLER" ]; then
        . $PLATFORM_INSTALLER
    else
        echo "No dependencies installer for platform \"$(uname)\" found."
        cat << EOF
The following dependencies are expected:
- NVIM
- A recent version of git
- tmux
EOF
        [[ $(BoolPrompt "Continue?") -eq 0 ]] && exit
    fi

    # Grab all configs and link them
    InstallDir "$DOTFILES_DIR/configs" $PREFIX;

    # Install Vundle for neovim
    git clone https://github.com/VundleVim/Vundle.vim.git \
        ~/.config/nvim/bundle/vundle
    nvim +PluginInstall +qall

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

    git config --global core.editor "vim"

    # Create a local bash config for things we don't want to have versioned
    # This one is outside the usual configs/ because we don't want changes
    # across machines versioned
    cp $DOTFILES_DIR/bashlocalrc ~/.bashlocalrc

    echo "Done."
    return $RetVal
}

main $@
#cd .
