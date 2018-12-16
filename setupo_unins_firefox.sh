#!/bin/sh

sudo apt-get purge firefox

rm -r ~/.mozilla
sudo rm -r /etc/firefox /usr/lib/firefox /usr/lib/firefox-addons
