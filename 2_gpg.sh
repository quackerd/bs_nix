#!/bin/sh
KEYID=0x952103BA67FC389A

# gpg-agent Plugin
echo "Configuring oh_my_zsh..."
cat ~/.zshrc | sed 's/plugins=(\(.*\))/plugins=(gpg-agent \1)/g' | tee ~/.zshrc > /dev/null

echo "Configuring GPG agent..."
mkdir -p ~/.gnupg
tee -a ~/.gnupg/gpg-agent.conf << END
enable-ssh-support
default-cache-ttl 60
max-cache-ttl 120
END

echo "Importing public keys..."
gpg --recv $KEYID

echo "Please trust the imported key."
gpg --edit-key $KEYID
