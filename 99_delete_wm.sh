#!/bin/sh

echo "Cleaning garbage..."
sudo dnf remove i3 lightdm awesome dwm openbox qtile ratpoison xmonad*
sudo systemctl enable gdm

