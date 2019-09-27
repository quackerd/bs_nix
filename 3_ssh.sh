#!/bin/sh

echo "Configuring SSH..."

mkdir -p ~/.ssh
cat ssh_pub >> ~/.ssh/authorized_keys
chmod 700 ~/.ssh
chmod 644 ~/.ssh/authorized_keys
chmod 644 ~/.ssh/config
