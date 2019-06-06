#!/bin/sh

echo "Enabling RPMFusion..."
sudo rpm-ostree install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

echo "Enabling VScode"
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'

sudo dnf update -y

sudo dnf install -y vim \
		arc-theme \
	       	gnome-tweaks \
	       	paper-icon-theme \
		powerline-fonts \
	       	ibus-pinyin \
	       	clang \
	       	lld \
	       	nasm \
	       	cmake \
	       	bochs \
	        qemu \
		xorriso \
	       	git \
	       	dconf-editor \
		steam \
		code 

ibus restart

