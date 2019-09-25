#!/bin/sh

# PACKAGES
echo "Setting up packages..."
cp /etc/apt/sources.list /etc/apt/sources.list.backup
cat /etc/apt/sources.list.backup | sed -E 's/deb(.*)/deb\1 contrib non-free/g' > /etc/apt/sources.list

apt-get update
apt-get upgrade
apt-get install -y vim git wget curl sudo

# SSH KEY
mkdir /home/quackerd/.ssh
cat << EOT >> /home/quackerd/.ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC+IsyBTcVbcgk+zabvFEVOWPB3eGVDlJSyNikl3DTYScYPVYIKMTdQ9E9T2bDrGaTG3fTfATqiCcQmOGTOtKcpHGwiHxb9aMYmQ6fQFt3ry5zByX393/zYoH1oxVKNcnqkAPAmCuunsgjts5buY+Xes6paem/vIY4/qVXn/SgackroGh0dN1coNOZGqhTGKF84GcFir20TyFTunV2Yly86Z3RnbR4gJ5BPcyIGqB0IFT7OBsVwLFFCZ2cYrILUuFp4JCbkEUvBeT5IjXzyIVgGCszrA/gzk5rTMDiSZhH2CXbr2u6TZGoKT/UuRnkRuzmP36vhWMk7sn9dgiu+RhNof08Z1HUHh2875CY0BMekyAK7DZbCUT3hvZK5Chdx3A/+JFLwIPjVoeYJAQ2qzlCojFYXPaCJdxRVIBda13aHKE0WXELaxqoVQWzEPjv+v/p4ifEkeBdszo+mCLR71isuyyDSfSvCLC/PEq9xxWEh19SJR7RJOZOrBEeaH8Yip6+gALSB6jeKw/IRyH637wLDx3941R+4XKCCQlszydgIOTZuXwQ9yTM4/4S7tIMcAWajkSa2u0fBTvm+3jl3B0+b5Vr/7GHcDzbFFp2lpFSFF/wWQjZSvoJgV+/du6bDK24ZHdb6iS55k/D32V1KfH4LbyjNppPl13c8clgnKLkR+w==
EOT
chown quackerd:quackerd /home/quackerd/.ssh
chown quackerd:quackerd /home/quackerd/.ssh/authorized_keys
chmod 700  /home/quackerd/.ssh
chmod 644  /home/quackerd/.ssh/authorized_keys

# SSHD
echo "Setting up sshd..."
cp /etc/ssh/sshd_config /etc/ssh/sshd_config.backup
cat /etc/ssh/sshd_config.backup | \
sed -E 's/#+PermitRootLogin.*/PermitRootLogin no/g' | \
sed -E 's/#+PasswordAuthentication.*/PasswordAuthentication no/g' | \
sed -E 's/#+ChallengeResponseAuthentication.*/ChallengeResponseAuthentication no/g' | \
sed -E 's/#+X11Forwarding.*/X11Forwarding yes/g' | \
sed -E 's/#+Port .*/Port 77/g' > /etc/ssh/sshd_config

cat << EOT >> /etc/ssh/sshd_config

Match address 192.168.2.0/24
        PermitRootLogin without-password
        PasswordAuthentication yes

Match address 129.97.75.0/24
        PasswordAuthentication yes

EOT

# DOCKER
echo "Setting up docker..."
apt-get install -y \
     apt-transport-https \
     ca-certificates \
     curl \
     gnupg2 \
     software-properties-common

add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"

apt-get update
apt-get install docker-ce docker-compose
systemctl enable docker
systemctl start docker

# KVM
apt -y install qemu-kvm libvirt-daemon  bridge-utils virtinst libvirt-daemon-system virt-manager

# zfs
apt -y install zfs-dkms

# cockpit
apt -y install cockpit

