#!/bin/bash
pkg_mngr='apt-get'
pkgs='openvpn vim-nox netcat nmap sudo finger python3'
m_0='idoit'
p_key='test.pub'
user='xenu'
email='kittens@mailinator.com'
pass='x0x0x0x'
salt='0x0x0x0'
holes='22 666'

function root_check() {
	if [[ "$EUID" -ne 0 ]]; then
		echo "root"
		sleep 1
		echo $m_0
		sleep 1
		exit 0
	else
		echo "root [+]"
	fi
}
function update_schmupdate() {
	echo "update schmupdate"
	sleep 1
	$pkg_mngr update || fail_net
	$pkg_mngr install -y $pkgs
}

function set_ssh() {
	echo "Setting Keys."
	if [[ -e '/home/$user/.ssh' ]]; then
		echo 'ssh exists. skipping.'
		sleep 1
	else
		mkdir /home/$user/.ssh
		chmod 700 /home/$user/.ssh
		touch /home/$user/.ssh/authorized_keys
		chmod 600 /home/$user/.ssh/authorized_keys
		cat ${p_key} | /home/$user/.ssh/authorized_keys
		chown -R $user:$user /home/$user/.ssh
		echo "Set Keys."
		sleep 1
		cat /home/$user/.ssh/authorized_keys
		sleep 1
	fi

}

function pee_check() {
	pub=$p_key
	if [[ ! -e $pub ]]; then
			echo "no key"
			sleep 1
		else
			echo "key [+]"
			sleep 1
			cat $pub
	fi
}

function py_check() {
	pp='/usr/bin/python3'
	if [[ ! -e $pp ]]; then
			echo "no python3"
			update_schmupdate
		else
			echo "python3 [+]"
			#python __init__.py
			#exit 1
	fi
}
fail_net() {
	echo 'do something about internet'
}

ufw_armed() {
	for port in $holes;
	do
		ufw allow $port/tcp;
		echo "$port [+]"
		sleep 1
	done
}

bounce_ssh() {
	service ssh force-restart
	echo "bounced ssh"
	sleep 1
}
bounce_ufw() {
	ufw --force enable
	echo "bounced ufw"
	sleep 1
}
function making_babies() {
	if [[ ! -e "/home/$user/.cry" ]]; then
		mkdir /home/$user/.cry
		chmod a+x sys_proceed load
		chown -R $user:$user sys_proceed load
		echo "babies made"
		sleep 1
	else
		echo "already cry'd"
		sleep 1
	fi
		rsync -avp line/* /home/$user/.cry/
		rsync -avp load/*.conf /etc/profile.d/
		sleep 1
}

rock() {
    read -r -p "${1:-Rock and Roll? [y/N]} " response
    case $response in
        [yY][eE][sS]|[yY])
            true
						echo "reboot [+]"
						sleep 1
						reboot
            ;;
        *)
            false
						echo 'bad'
            ;;
    esac
}
ufw_armed
#root_check
#set_ssh
#pee_check
#py_check
#update_schmupdate
#making_babies
