#!/bin/bash
###############################################################################
# Debian.sh
# This script handles installing the core packages for Debian.
# Must define INSTALLER_CMD
###############################################################################

# ensure we have a package manager and it's up to date
sudo aptitude update
sudo aptitude upgrade

# Provide installer cmd
export INSTALLER_CMD="sudo aptitude install " 

# Install all of the listed packages 
$INSTALLER_CMD ${COMMON_CORE_PKGS[@]}

echo "Debian core setup complete."
