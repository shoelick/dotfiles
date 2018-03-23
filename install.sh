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

    source "$DOTFILES_REPO_DIR/util.sh"

    AreArgsValid "$@"

    #
    # Move dotfiles to final location
    #
    ConfigureDotfilesDir
    RetVal=$?
    [ $RetVal -gt 0 ] && return $RetVal;

    # Install global gitignore
    #InstallFiles "$DOTFILES_DIR/shoes/.gitignore_global" "$HOME"

    #
    # Installation
    #
    InstallDir "$DOTFILES_DIR/configs" $HOME;
    git clone https://github.com/VundleVim/Vundle.vim.git \
        ~/.config/nvim/bundle/vundle
    echo "Don't forget to install neovim and run :PluginInstall"

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

    echo "Done."
    return $RetVal

    # Perfom modification to agnoster theme
    # Changes PS1 to show up to 3 directories up from pwd
    # The single '' after -i makes the command macOS-safe
    sed -i '' -e "s/blue black '%\~'/blue black '%3\~'/g" \
        "${HOME}/.oh-my-zsh/themes/agnoster.zsh-theme" 2>/dev/null
} 

main $@
#cd .
