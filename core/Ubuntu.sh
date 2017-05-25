#!/bin/bash
###############################################################################
# %platform%.sh
# This script handles installing the core packages for %platform%.
# Must define INSTALLER_CMD
###############################################################################

# ensure we have a package manager and it's up to date
apt-get update 

# Provide installer cmd
export INSTALLER_CMD="apt-get -y install " 

# Install all of the listed packages 
$INSTALLER_CMD ${COMMON_CORE_PKGS[@]}

echo "%platform% core setup complete."
