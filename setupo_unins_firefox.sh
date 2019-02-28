#!/bin/sh

sudo dnf remove firefox

rm -r ~/.mozilla
sudo rm -r /etc/firefox /usr/lib/firefox /usr/lib/firefox-addons
