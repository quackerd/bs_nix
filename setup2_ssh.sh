#!/bin/bash

echo "Setting up GnuPG..."
sudo dnf install -y gnupg
gpg -d id_ed25519.gpg > id_ed25519

echo "Copying private key..."
mkdir -p ~/.ssh
chmod 700 ~/.ssh
cp id_ed25519 ~/.ssh/
cp id_ed25519.pub ~/.ssh/
chmod 600 ~/.ssh/id_ed25519
chmod 644 ~/.ssh/id_ed25519.pub

