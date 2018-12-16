#!/bin/bash

if [[ -z "$1" ]] ; then
echo "ERROR - invalid arguments"
echo "Usage: win_username"
echo "win_username: Required. The username of Windows."
exit 1
fi

#setup WSL

WSL_USER=$1
SSHD_PORT=77
SSHD_FILE=/etc/ssh/sshd_config
SUDOERS_FILE=/etc/sudoers

sudo apt-get update
sudo apt-get install -y openssh-server build-essential cmake gdb

# 1.1. configure sshd
sudo sed -i '/^Port/ d' $SSHD_FILE
sudo sed -i '/^PasswordAuthentication/ d' $SSHD_FILE
echo "# configured for CLion"      | sudo tee -a $SSHD_FILE
echo "Port ${SSHD_PORT}"          | sudo tee -a $SSHD_FILE
echo "PasswordAuthentication yes" | sudo tee -a $SSHD_FILE

# 1.2. apply new settings
sudo ssh-keygen -A
sudo service ssh --full-restart
sudo systemctl enable ssh

echo "# ENV VAR for WSL" >> ~/.bashrc 
echo "export WHOME=\"/mnt/c/Users/$WSL_USER\"" >> ~/.bashrc 
echo "export WDOC=\"\$WHOME/Documents\"" >> ~/.bashrc 
echo "export WDESK=\"\$WHOME/Desktop\"" >> ~/.bashrc 
echo "export DISPLAY=:0" >> ~/.bashrc

echo "WSL summary"
echo "\$WHOME is set to /mnt/c/Users/$WSL_USER"
echo "\$WDOC is set to \$WHOME/Documents"
echo "\$WDESK is set to \$WHOME/Desktop"
echo "SSH server parameters ($SSHD_FILE):"
echo "Port ${SSHD_PORT}"
echo "PasswordAuthentication yes"