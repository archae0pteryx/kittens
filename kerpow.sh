#!/bin/bash

################################# VARS ###############################
user="xenu"

apt update
apt -y upgrade
apt-get autoremove
apt install vim-nox git openvpn
echo "Installed Core Apps"
sleep 2
echo "Making Sudoer."
useradd -m -G sudo,adm -s /bin/bash $user
echo "Setting Keys."
sleep 2
mkdir /home/$user/.ssh
chmod 700 /home/$user/.ssh
touch /home/$user/.ssh/authorized_keys
chmod 600 /home/$user/.ssh/authorized_keys
cat >> /home/$user/.ssh/authorized_keys << $user.pub
chown -R $user:$user /home/$user/.ssh
echo "Set Keys."
echo "Lets Check. Shall We?"
cat /home/$user/.ssh/authorized_keys
sleep 2
echo "Good?"
sleep 2
service ssh restart
echo "Modifying ssh_config"
sed -i "s/PermitRootLogin yes/PermitRootLogin no/g" /etc/ssh/sshd_config
sed -i "s/Port 22/Port 1234/g" /etc/ssh/sshd_config
sed -i "s/#PasswordAuthentication yes/PasswordAuthentication no/g" /etc/ssh/sshd_config
service ssh restart

# Firewall
ufw allow ssh
ufw allow 666
ufw enable
exit
