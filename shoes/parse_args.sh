#!/bin/bash
###############################################################################
# parse_args.sh
# This file provides functions for parsing and verifying the arguments 
# to shoefiles
###############################################################################


## AreArgsValid <Passed parameters array>
# Returns 0 if the passed arguments are valid based on shoesfiles 
# configuration.
function AreArgsValid() {

    Debug "AreArgsValid Received $@"

    Cmd=$1
    Target=$2
    RetVal=$ERROR_CODE_NONE

    # Subcommand is required
    if ! containsElement $Cmd $SUPPORTED_CMDS ; then
        Debug "$Cmd not in $SUPPORTED_CMDS"
        echo "Invalid subcommand."
        RetVal=$ERROR_CODE_INVALID_ARGS;
    fi
   
    # Check for valid target
    # First condition is Bash's annoying way of saying "if (var is not null)"
    if [[ ! -z ${Cmd+"fuckme"} ]] && ! containsElement $Target $SUPPORTED_TARGETS ; then
        Debug "$Target is not in $SUPPORTED_TARGETS";
        echo "Invalid target."
        RetVal=$ERROR_CODE_INVALID_ARGS;
    fi

    return $RetVal;
}

#
#
#
#
DetectPlatform() {

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
    #export DISTRO=`echo $DISTRO_RAW | perl -lne '/(Ubuntu)|(Debian)|(Darwin)|(Arch)|(Fedora)/gi && print $&' | head -n1`

}

#
#
#
function GetAction() {
    
    RetVal = 0;
    

    return 0;
}
