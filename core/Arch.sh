#!/bin/bash
###############################################################################
# Arch.sh
# This script handles installing the core packages for Arch Linux.
# Must define INSTALLER_CMD
###############################################################################

# ensure we have a package manager and it's up to date
pacman -Syyu

# Provide installer cmd
export INSTALLER_CMD="pacman -S " 

# Install all of the listed packages 
$INSTALLER_CMD ${COMMON_CORE_PKGS[@]}

echo "Arch core setup complete."
