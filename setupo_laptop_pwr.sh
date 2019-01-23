#!/bin/bash

echo "Installing power-saving packages"
sudo apt install -y powertop tlp
sudo apt-get -y autoremove

echo "Edit /etc/default/tlp such that the default mode is BAT"