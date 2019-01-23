#!/bin/bash

echo "Installing keychain..."
sudo apt install keychain

echo "Copying private key..."
cp id_op52 ~/.ssh/id_op52

echo "Configuring keychain..."
echo "# Configured for keychain" >> ~/.bashrc
echo "eval \`keychain --eval --agents ssh id_op52\`" >> ~/.bashrc
