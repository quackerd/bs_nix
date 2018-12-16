#!/bin/bash

KEY_GRIP=5351806D27F0E18166370620F4ED903E973C03C6

echo "Importing keys"
gpg --import gpgkey.pub
gpg --import gpgkey.pri

echo "Adding ssh support"
echo "enable-ssh-support" >> $HOME/.gnupg/gpg-agent.conf
cat _gpg_bashrc >> $HOME/.bashrc
echo $KEY_GRIP >> $HOME/.gnupg/sshcontrol

echo "Restarting gpg-agent"
gpgconf --kill gpg-agent
gpgconf --launch gpg-agent

echo "Please use \"gpg --editkeys key_id\" to trust your keys"