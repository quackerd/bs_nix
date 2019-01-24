#!/bin/bash

echo "Installing keychain..."
sudo apt install keychain

echo "Copying private key..."
cp id_op52 ~/.ssh/id_op52
cp id_op52.pub ~/.ssh/id_op52.pub
chmod 600 ~/.ssh/id_op52
chmod 644 ~/.ssh/id_op52.pub

echo "Configuring keychain..."
echo "# Configured for keychain" >> ~/.bashrc
echo "eval \`keychain --quiet --eval --agents ssh id_op52\`" >> ~/.bashrc
