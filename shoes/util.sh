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

    echo "Usage: shoefiles <subcommand> [target]"
    echo "Supported subcommands: $SUPPORTED_CMDS"
    echo "Supported targets: $SUPPORTED_TARGETS"

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
    # First condition is Bash's annoying way of saying "if (var is not null)"
    if [[ ! -z ${SUBCMD+"fuckme"} ]] && ! containsElement $TARGET $SUPPORTED_TARGETS ; then
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

    echo $DISTRO_RAW
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
            echo -e "\e[5mWARNING!"
            PROMPT="$DOTFILES_REPO_DIR/dotfiles.backup exists. Obliterate backup? " 
            CONTINUE=$(BoolPrompt "$PROMPT")
        fi
    fi

    # Exit if user told us to.
    if [ $CONTINUE = 0 ]; then
        echo "Empty/delete existing backup and try again." 
        return $ERROR_CODE_FAIL
    # Make sure the backup dir doesn't exist
    else 
        [ -d "$BUPDIR" ] && rm -v "$BUPDIR"
    fi

    cd "$HOME"
    # If the repo is not the final location and the final location exists
    if  [ -d "$DOTFILES_DIR"  ]; then
        # Move existing dotfiles dir to a backup dir
        # A link will not be moved
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
        INPUT = ${INPUT,,} # make lowercase
        [[ ($INPUT = "y" || $INPUT = "n") ]] && DONE=1 
    done;
    echo [[ $INPUT = "y" ]]
}
