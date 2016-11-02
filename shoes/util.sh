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

#
#
#
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
        Debug "Platform is $PLATFORM"
        [[ ! -z ${PLATFORM+"hehehe"} ]] && break;
    done

    # Report error 
    [[ ! -z ${PLATFORM+"shnikey!"} ]] && RetVal=$ERROR_CODE_FAILURE && \
        echo "Welp. We don't have your back this time fam. OS not supported." 

    return $RetVal
}
