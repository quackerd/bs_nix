#!/bin/bash

echo "Installing undervolt packages"
sudo apt install -y python-pip
sudo apt-get -y autoremove
sudo pip install undervolt


echo "Applying undervolt"
sudo cp _undervolt /etc/systemd/system/undervolt.service
sudo cp _undervolt_timer /etc/systemd/system/undervolt-timer.service

sudo systemctl enable undervolt-timer
sudo systemctl start undervolt-timer