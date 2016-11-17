#!/bin/bash
###############################################################################
# util.sh
# This script file contains a collection of useful helper function.
###############################################################################

#
# containsElement
# $1 - Search element
# $2 - List
# Returns 1 if the search element is contained with the list
#
containsElement () {
    local e
    for e in "${@:2}"; do [[ "$e" == "$1" ]] && return 0; done
    return 1
}

#
# Debug
# $1 Debug string
# Prints the passed debug string if the $DEBUG is set
#
Debug () {

    if [ ! -z ${DEBUG_OUTPUT+"shitt"} ] ; then 
        echo "DEBUG: $@"
    fi

}

#
# Print helpful Usage message for user.
# 
PrintUsage() {

    echo "Usage: shoefiles <subcommand> <target>"
    echo "Supported subcommands: $SUPPORTED_CMDS"
    echo "Supported packages: $SUPPORTED_PKGS"
    echo "Supported groups: $SUPPORTED_GROUPS"

}

## AreArgsValid <Passed parameters array>
# Returns 0 if the passed arguments are valid based on shoesfiles 
# configuration.
function AreArgsValid() {

    Debug "AreArgsValid Received $@"

    SUBCMD=$1
    TARGET=$2
    RetVal=$ERROR_CODE_NONE

    # Subcommand is required
    if ! containsElement $SUBCMD $SUPPORTED_CMDS ; then
        Debug "$SUBCMD not in $SUPPORTED_CMDS"
        echo "Invalid subcommand."
        RetVal=$ERROR_CODE_INVALID_ARGS;
    fi
   
    # Check for valid target
    if [[ ! -z ${SUBCMD} ]] && ! containsElement $TARGET $SUPPORTED_TARGETS ; then
        Debug "$TARGET is not in $SUPPORTED_TARGETS";
        echo "Invalid target."
        RetVal=$ERROR_CODE_INVALID_ARGS;
    fi

    return $RetVal;
}

#
# Sets PLATFORM to be a one-word string defining operating system.
# @depends SUPPORTED_OS String of space-separated supported 
#           operating systems.
#
DetectPlatform() {

    Debug "Let's see whatcha got here..."
    RetVal=$ERROR_CODE_NONE

    # Get *nix distro
    DISTRO_RAW="" # Gets raw os output
    DISTRO_RAW_LOC=`echo /etc/*-release` 2> /dev/null

    # If DISTRO_RAW_LOC still contains the '*' (didn't use regex) empty DISTRO_RAW_LOC
    if [[ "$DISTRO_RAW_LOC" == "/etc/*-release" ]]; then
        DISTRO_RAW_LOC="";
    fi

    # get contents of uname or lsb-release
    if [[ "$DISTRO_RAW_LOC" != "" ]]; then
        DISTRO_RAW=$(cat /etc/*-release 2> /dev/null)
    else
        DISTRO_RAW=$(uname)
    fi

    # Parses out specific distro
    for OS in $SUPPORTED_OS; do 
        Debug "Checking for $OS..."
        PLATFORM=$(echo $DISTRO_RAW | grep -o "$OS")
        [[ ! -z ${PLATFORM+"hehehe"} ]] && break;
    done

    # Report error 
    Debug "Platform is $PLATFORM"
    [[ -z ${PLATFORM+"shnikey!"} ]] && RetVal=$ERROR_CODE_FAILURE && echo "Welp. We don't have your back this time fam. OS not supported." 

    return $RetVal
}

#
# Set up and move .dotfiles directory
# The back up directory does NOT exist by default.
# Its presence indicates an existing backup.
# @depends HOME
# @depends DOTFILES_REPO_DIR Location of the repository
# @depends DOTFILES_DIR Final destination
# 
ConfigureDotfilesDir() {

    RETVAL=$ERROR_CODE_NONE
    CONTINUE=1
    BUPDIR=$DOTFILES_REPO_DIR/dotfiles.backup

    # If we are running from final destination, no worries.
    if [ "$DOTFILES_REPO_DIR" = "$DOTFILES_DIR" ]; then
        Debug "Already in final destination. Not moving."
        return $ERROR_CODE_NONE;

    # Otherwise, check if final destination exists
    elif [ -e "$DOTFILES_DIR" ]; then

        Debug "Dotfiles directory exists and we're not in it."
        # Check if backup directory exists
        if [ -e "$BUPDIR" ]; then
            echo -e "!!! WARNING !!!"
            PROMPT="$DOTFILES_REPO_DIR/dotfiles.backup exists. Obliterate backup directory? " 
            CONTINUE=$(BoolPrompt "$PROMPT")
        fi
    fi

    # Exit if user told us to.
    if [ $CONTINUE -eq 0 ]; then
        echo "Delete existing backup and try again." 
        return $ERROR_CODE_FAILURE
    # Make sure the backup dir doesn't exist
    else 
         [ -d "$BUPDIR" ] && echo "Deleting $BUPDIR" && rm -r "$BUPDIR"
    fi

    cd "$HOME"
    # If the repo is not the final location and the final location exists
    if  [ -d "$DOTFILES_DIR"  ]; then
        # Move existing dotfiles dir to a backup dir
        # A link will not be moved (@todo why did I write this?)
        mkdir -pv "$BUPDIR"
        mv -v "$HOME/.dotfiles" "$DOTFILES_REPO_DIR/dotfiles.backup"
    fi

    # Move repo to final destination
    mv -v "$DOTFILES_REPO_DIR" "$DOTFILES_DIR"
    cd "$HOME/.dotfiles"
    DOTFILES_BACKUP="$DOTFILES_DIR/dotfiles.backup"

    return $RETVAL
}

#
# BooleanPrompt
# Prompts the user for a yes or no answer
# @param $1 takes in a string prompt
# 0 on true or 1 on false
#
BoolPrompt() {
    
    DONE=0
    while [ ! $DONE = 1 ]; do
        read -p "$1 [Y/n]: " INPUT; # prompt
        INPUT=$(echo "$INPUT" | tr '[A-Z]' '[a-z]') # make lowercase
        [[ ( $INPUT = "y" || $INPUT = "n" ) ]] && DONE=1 
    done;
    [[ $INPUT = "n" ]] # logic's a bitch
    echo $?
}

#
# EmailPrompt
# Prompts the user for an email string
# @param $1 takes a string prompt
# 0 for matching string, 1 for unmatch
#
EmailPrompt() {
    DONE=0
    while [ ! $DONE = 1 ]; do
        read -p "$1" INPUT; # prompt
        if [[ "$INPUT" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$ ]]; then
            DONE=1     
        fi
    done
    echo $INPUT;
}

#
# InstallFiles
# Installs the passed file or directory into the passed location, 
# backing up the file already at the destination if it exists.
# The passed destination is assumed to be prepended with $HOME
# @param $1 Path to new source file to install
# @param $2 Destination path, filename or target NOT included
# @depends HOME
# @depends DOTFILES_BACKUP Storage location for any existing dotfiles
# @depends PKG_CONFIG Directory of configuration files to be linked from $HOME
#
# @note While reading what this function does, remember that a directory is 
# also a type of file
#
InstallFiles() {

    RETVAL=$ERROR_CODE_NONE
    NEW_FILE_PATH="$1" # Location of original source file
    NEW_FILE_NAME=$(basename "$NEW_FILE_PATH")
    DEST_PATH=$2 
    BUPDIR=$DOTFILES_REPO_DIR/dotfiles.backup
    CONTINUE=1

    Debug "Looking to install $NEW_FILE_PATH at $DEST_PATH"
    Debug "File name itself is $NEW_FILE_NAME"

    # @todo change to account for when destination exists and already is symlink to dotfiles
    # Check if file exists at destination
    if [ -e "$DEST_PATH/$NEW_FILE_NAME" ]; then
        # Check if file with this name already exists in backup
        if [ -e "$BUPDIR/$NEW_FILE_NAME" ]; then
            echo -e "!!! WARNING !!!"
            PROMPT="$BUPDIR/$(basename $DEST_PATH) exists. Obliterate backup? " 
            CONTINUE=$(BoolPrompt "$PROMPT")
        fi 
    fi 

    # Exit if user told us to
    if [ $CONTINUE -eq 0 ]; then
        echo "Delete existing backup or destination and try again." 
        RETVAL=$ERROR_CODE_FAILURE
    else 
        # Make sure the backup doesn't exist
        Debug "Seeing if $BUPDIR/$NEW_FILE_NAME exists..." 
        if [ -e "$BUPDIR/$NEW_FILE_NAME" ]; then 
            echo "Deleting $BUPDIR/$NEW_FILE_NAME"
            rm -rv "$BUPDIR/$NEW_FILE_NAME"
        fi

        # Finally, back up 
        mv -v "$DEST_PATH/$NEW_FILE_NAME" "$BUPDIR"

        # Install
        ln -sv "$NEW_FILE_PATH" "$DEST_PATH/$NEW_FILE_NAME" 
    fi

    return $RETVAL
}

#
# SetupPackage 
# Sources package scripts and runs their installation/configuration
# @param $1 Name of package to install
# @depends $DOTFILES_DIR Root directory of dotfiles repo
# 
SetupPackage () {

    RETVAL=$ERROR_CODE_NONE
    PKG_NAME=$1
    PKG_CONFIG="${DOTFILES_DIR}/packages/${PKG_NAME}/config"
    Debug "Using $PKG_CONFIG to install $PKG"

    # Verify required script exists
    PKG_SCRIPT="${PKG_CONFIG}/../${PKG_NAME}.sh"
    if [ ! -f "$PKG_SCRIPT" ]; then
        RETVAL=$ERROR_CODE_INVALID_ARGS
        echo "Checked: $PKG_SCRIPT"
        echo "Invalid package name provided."
    else
        # Source package install script
        # All should include definitions for:
        # Install, Configure
        source "$PKG_SCRIPT"
        Install && RETVAL=$?
        [ $RETVAL == 0 ] && Configure && RETVAL=$?
        unset -f Install Configure
    fi

    return $RETVAL
}

