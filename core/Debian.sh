#!/bin/bash
###############################################################################
# Debian.sh
# This script handles installing the core packages for Debian.
# Must define INSTALLER_CMD
###############################################################################

echo "Running core Debian set up"

# ensure we have a package manager and it's up to date
sudo aptitude update
sudo aptitude upgrade

# Provide installer cmd
export INSTALLER_CMD="sudo aptitude install " 

ONE="deb     http://ftp.de.debian.org/debian/    testing main contrib non-free"
TWO="deb-src http://ftp.de.debian.org/debian/    testing main contrib non-free"
THREE="deb     http://security.debian.org/         testing/updates  main contrib non-free"

# Install all of the listed packages 
$INSTALLER_CMD ${COMMON_CORE_PKGS[@]}

echo "Debian core setup complete."
