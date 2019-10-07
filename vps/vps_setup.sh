#!/bin/sh
# packages
USER=$1

yum update -y
yum install -y vim git zsh curl wget sudo policycoreutils-python python3 epel-release

# sanoid and epel stuff
cat << EOT >> /etc/sudoers
#
# configured by the script
#
Defaults rootpw
EOT

# SSH KEY
mkdir /home/$USER/.ssh
cat << EOT >> /home/quackerd/.ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC+IsyBTcVbcgk+zabvFEVOWPB3eGVDlJSyNikl3DTYScYPVYIKMTdQ9E9T2bDrGaTG3fTfATqiCcQmOGTOtKcpHGwiHxb9aMYmQ6fQFt3ry5zByX393/zYoH1oxVKNcnqkAPAmCuunsgjts5buY+Xes6paem/vIY4/qVXn/SgackroGh0dN1coNOZGqhTGKF84GcFir20TyFTunV2Yly86Z3RnbR4gJ5BPcyIGqB0IFT7OBsVwLFFCZ2cYrILUuFp4JCbkEUvBeT5IjXzyIVgGCszrA/gzk5rTMDiSZhH2CXbr2u6TZGoKT/UuRnkRuzmP36vhWMk7sn9dgiu+RhNof08Z1HUHh2875CY0BMekyAK7DZbCUT3hvZK5Chdx3A/+JFLwIPjVoeYJAQ2qzlCojFYXPaCJdxRVIBda13aHKE0WXELaxqoVQWzEPjv+v/p4ifEkeBdszo+mCLR71isuyyDSfSvCLC/PEq9xxWEh19SJR7RJOZOrBEeaH8Yip6+gALSB6jeKw/IRyH637wLDx3941R+4XKCCQlszydgIOTZuXwQ9yTM4/4S7tIMcAWajkSa2u0fBTvm+3jl3B0+b5Vr/7GHcDzbFFp2lpFSFF/wWQjZSvoJgV+/du6bDK24ZHdb6iS55k/D32V1KfH4LbyjNppPl13c8clgnKLkR+w==
EOT
chown $USER:$USER /home/$USER/.ssh
chown $USER:$USER /home/$USER/.ssh/authorized_keys
chmod 700  /home/$USER/.ssh
chmod 644  /home/$USER/.ssh/authorized_keys

# DOCKER
echo "Setting up docker..."
yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
yum update
yum install -y docker
systemctl enable docker
systemctl start docker

curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

systemctl stop firewalld
systemctl mask firewalld

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

systemctl restart sshd

