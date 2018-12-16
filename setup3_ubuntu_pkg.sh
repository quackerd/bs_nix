#!/bin/bash

echo "Installing packages"
sudo add-apt-repository -y -u ppa:snwh/ppa
sudo add-apt-repository -y ppa:graphics-drivers
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt install -y vim arc-theme gnome-tweak-tool paper-icon-theme ibus-pinyin clang lld qemu cmake nasm grub-pc-bin bochs bochs-sdl xorriso
sudo apt-get -y autoremove
ibus restart