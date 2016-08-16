#!/bin/bash

################################# VARS ###############################
user="SET_USER"
pass="SET_PASSWORD"
pub="SET_PUB_KEY"
core="SET_CORE" #Space seperated
######################################################################

########### Check Files / Vars ###################################
if [ $pass="SET_PASSWORD" || $user="SET_USER" || $core="SET_CORE"]
then
	echo "Dum Dum. VARS at the top of script... set them."
fi

if [ -f "$pub" ]
then
	echo "$pub found."
else
	echo "$pub Where's your fucking public key bra!?"
fi

########################################################
##### Check Shell ###### Taken from NYR/openvpn-install
if readlink /proc/$$/exe | grep -qs "dash"; then
	echo "sh? nah, BASH"
	exit 1
fi
if [[ "$EUID" -ne 0 ]]; then
	echo "ERRRRNT! ROOT DAMN IT, ROOT!"
	exit 2
fi
if [[ ! -e /dev/net/tun ]]; then
	echo "You have no TUN. Bad Monkey!"
	exit 3
fi
#########################
sleep 2
echo "k. Updating..."
apt update
apt -y upgrade
apt-get autoremove
apt install -y $core
echo "Installed Core Apps"
sleep 2
echo "Making Sudoer."
useradd -m -G sudo -s /bin/bash $user
echo $pass | passwd $user --stdin
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
