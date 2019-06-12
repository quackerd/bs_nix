#!/bin/sh

KEYID=0x952103BA67FC389A

# gpg-agent Plugin
echo "Configuring zsh..."
cat ~/.zshrc | sed 's/plugins=(\(.*\))/plugins=(gpg-agent \1)/g' > ~/.zshrc
echo "# Workaround for gpg" >> ~/.zshrc
echo "gpg-connect-agent updatestartuptty /bye > /dev/null" >> ~/.zshrc

echo "Importing public keys..."
gpg --recv $KEYID

echo "Please trust the imported key."
gpg --edit-key $KEYID
