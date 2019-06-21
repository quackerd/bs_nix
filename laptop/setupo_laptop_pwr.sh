#!/bin/bash

echo "Installing power-saving packages"
sudo dnf install -y powertop tlp

echo "Edit /etc/default/tlp such that the default mode is BAT"
