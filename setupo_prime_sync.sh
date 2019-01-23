#!/bin/bash

sudo cp _nv_modeset /etc/modprobe.d/zz-nvidia-modeset.conf
sudo update-initramfs -u