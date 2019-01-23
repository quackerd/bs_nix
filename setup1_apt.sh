#!/bin/bash

# create apt snapshot and script for manually installed packages
echo "Creating APT snapshot..."
mkdir ~/.pkgsrc
apt-mark showmanual > ~/.pkgsrc/pkgs_org
echo "Creating APT script..."
cp ./_show_pkgs ~/show_pkgs
chmod +x ~/show_pkgs

