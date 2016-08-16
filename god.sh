#!/bin/bash
user="xenu"
pass="sK33t3r3"
core="git vim-nox finger" #Space seperated
pub="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCzvCHswOm1HkfoGW+hrOpDgyWxFkYwyot7/AmE5pZ2itgGfOaHuAHxaVSaTROv8AWHv9AJC4UvDr7kTuHtwk2mH9Fb20mAa1auAcL5YPpMFWfOn0LzCYMc1yVlkbv3OoKZ4vW4k1dDOJVMXMGQBZiK577SZ2FyIwAB1UMGs6KVWjAGYj5A/AazrnghkRCR/HtNbWQGCVo990DOsLMAIciLSyle70hQ//994w5/R1FS4NfiDVqkJo3mXeoCNyTbi93PAIBi2xQQIhUAia3D6FF58MswbMaM/j9Rnngr+9+FEYMqwgig2mL8PfwFpG4K7ibla3in6xfsLpMhBJyuGbpp antwan@steadman.local"
echo "Making Sudoer."
useradd -m -G sudo -s /bin/bash $user
echo $user:$pass | chpasswd
usermod -aG sudo $user
sleep 2
echo "SUDO POWER!"
sleep 1
echo "Setting Keys."
sleep 2
mkdir /home/$user/.ssh
chmod 700 /home/$user/.ssh
touch /home/$user/.ssh/authorized_keys
chmod 600 /home/$user/.ssh/authorized_keys
echo $pub >> /home/$user/.ssh/authorized_keys
chown -R $user:$user /home/$user/.ssh
echo "Set Keys."
sleep 2
echo "Lets Check. Shall We?"
cat /home/$user/.ssh/authorized_keys
sleep 2
echo "Good?"
sleep 3
echo "Modifying ssh_config"
sed -i "s/KeyRegenerationInterval 3600/KeyRegenerationInterval 360/g" /etc/ssh/sshd_config
sed -i "s/ServerKeyBits 1024/ServerKeyBits 2048/g" /etc/ssh/sshd_config
sed -i "s/PermitRootLogin yes/PermitRootLogin no/g" /etc/ssh/sshd_config
sed -i "s/#PasswordAuthentication yes/PasswordAuthentication no/g" /etc/ssh/sshd_config
sleep 3
echo "Modified."
service ssh restart
sleep 2
# Firewall
ufw allow ssh
ufw --force enable

echo "k. Updating..."
apt update
apt -y upgrade
apt-get autoremove
apt install -y $core
echo "Installed Core Apps"
sleep 2
echo "restarting"
sleep 4
reboot
