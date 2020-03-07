#!/bin/sh
# packages
cp /etc/dnf/dnf.conf /etc/dnf/dnf.conf.backup
cat /etc/dnf/dnf.conf.backup > sed -E "s/installonly_limit=.*/installonly_limit=2/g" > /etc/dnf/dnf.conf

# remove useless packages
dnf remove cockpit
dnf autoremove

dnf update -y
dnf install -y vim git curl wget sudo epel-release policycoreutils

# zsh
dnf install -y zsh sqlite

# sanoid
dnf install -y perl-Data-Dumper lzop mbuffer mhash pv perl-CPAN

cat << EOT >> /etc/sudoers
#
# configured by the script
#
Defaults rootpw
EOT

# SSH KEY
mkdir /home/quackerd/.ssh
cat << EOT >> /home/quackerd/.ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC+IsyBTcVbcgk+zabvFEVOWPB3eGVDlJSyNikl3DTYScYPVYIKMTdQ9E9T2bDrGaTG3fTfATqiCcQmOGTOtKcpHGwiHxb9aMYmQ6fQFt3ry5zByX393/zYoH1oxVKNcnqkAPAmCuunsgjts5buY+Xes6paem/vIY4/qVXn/SgackroGh0dN1coNOZGqhTGKF84GcFir20TyFTunV2Yly86Z3RnbR4gJ5BPcyIGqB0IFT7OBsVwLFFCZ2cYrILUuFp4JCbkEUvBeT5IjXzyIVgGCszrA/gzk5rTMDiSZhH2CXbr2u6TZGoKT/UuRnkRuzmP36vhWMk7sn9dgiu+RhNof08Z1HUHh2875CY0BMekyAK7DZbCUT3hvZK5Chdx3A/+JFLwIPjVoeYJAQ2qzlCojFYXPaCJdxRVIBda13aHKE0WXELaxqoVQWzEPjv+v/p4ifEkeBdszo+mCLR71isuyyDSfSvCLC/PEq9xxWEh19SJR7RJOZOrBEeaH8Yip6+gALSB6jeKw/IRyH637wLDx3941R+4XKCCQlszydgIOTZuXwQ9yTM4/4S7tIMcAWajkSa2u0fBTvm+3jl3B0+b5Vr/7GHcDzbFFp2lpFSFF/wWQjZSvoJgV+/du6bDK24ZHdb6iS55k/D32V1KfH4LbyjNppPl13c8clgnKLkR+w==
EOT
chown quackerd:quackerd /home/quackerd/.ssh
chown quackerd:quackerd /home/quackerd/.ssh/authorized_keys
chmod 700  /home/quackerd/.ssh
chmod 644  /home/quackerd/.ssh/authorized_keys

# DOCKER
echo "Setting up docker..."
dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
dnf update
dnf install -y https://download.docker.com/linux/centos/7/x86_64/stable/Packages/containerd.io-1.2.13-3.1.el7.x86_64.rpm
dnf install -y docker
systemctl enable --now docker

# DOCKER-COMPOSE
curl -L "https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

# KVM
dnf -y groupinstall 'Virtualization Host'
dnf install -y virt-manager xauth
systemctl start libvirtd
systemctl enable libvirtd

# zfs
dnf install -y http://download.zfsonlinux.org/epel/zfs-release.el8_1.noarch.rpm
dnf update

# SSHD
echo "Setting up sshd..."
semanage port -a -t ssh_port_t -p tcp 77
cp /etc/ssh/sshd_config /etc/ssh/sshd_config.backup
cat /etc/ssh/sshd_config.backup | \
sed -E 's/#* *PermitRootLogin.*/PermitRootLogin no/g' | \
sed -E 's/#* *PasswordAuthentication.*/PasswordAuthentication no/g' | \
sed -E 's/#* *ChallengeResponseAuthentication.*/ChallengeResponseAuthentication no/g' | \
sed -E 's/#* *X11Forwarding.*/X11Forwarding yes/g' | \
sed -E 's/#* *Port.*/Port 77/g' > /etc/ssh/sshd_config

cat << EOT >> /etc/ssh/sshd_config
Match address 129.97.75.0/24
        PasswordAuthentication yes
        PermitRootLogin without-password
EOT
systemctl restart sshd

# firewall
echo "Setting up firewall..."
cp /usr/lib/firewalld/services/ssh.xml /etc/firewalld/services/ssh.xml
cat /usr/lib/firewalld/services/ssh.xml | sed -E 's/port=\".*\"(.*)/port=\"77\"\1/g' > /etc/firewalld/services/ssh.xml
firewall-cmd --reload
firewall-cmd --permanent --add-service=ssh
firewall-cmd --permanent --remove-service=dhcpv6-client --remove-service=cockpit
firewall-cmd --reload

echo "Setup completed. Please install perl dependencies for sanoid and switch to zfs kmod repo."
echo "cpan - install Capture::Tiny - install Config::IniFiles"
