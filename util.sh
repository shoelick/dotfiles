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
    for e in "${@:2}"; do [[ "$e" == "$1" ]] && return ; done
    return 1
}

#
# Debug
# $1 Debug string
# Prints the passed debug string if the $DEBUG is set
#
Debug () {

    if [ ! -z ${DEBUG+notset} ] && [ $# -eq 1 ]; then 
        echo $1
    fi

}
