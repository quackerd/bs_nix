#!/bin/bash

echo "Installing packages"
sudo dnf upgrade
sudo dnf install -y vim arc-theme gnome-tweak-tool paper-icon-theme ibus-pinyin clang lld qemu nasm bochs xorriso git dconf-editor
ibus restart
