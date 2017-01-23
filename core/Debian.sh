#!/bin/bash
###############################################################################
# Debian.sh
# This script handles installing the core packages for Debian.
# Must define INSTALLER_CMD
###############################################################################

echo "Running core Debian set up"

# ensure we have a package manager and it's up to date
sudo apt-get update
sudo apt-get upgrade

# Provide installer cmd
export INSTALLER_CMD="sudo apt-get install " 
export UNINSTALL_CMD="sudo apt-get remove "

# Install all of the listed packages 
$INSTALLER_CMD ${COMMON_CORE_PKGS[@]}

echo "Debian core setup complete."
