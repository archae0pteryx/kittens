
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

pause () {
  read -p "Press [Enter] key to continue..." fackEnterKey
}
show_menus() {
	clear
	echo ""
	echo "(c)hecks"
	echo "(u)pdate"
	echo "(b)ase"
	echo "(m)ake babies"
	echo "(l)ine"
	echo "l(o)ad"
	echo "(r)ock"
	echo "e(x)it"
}
opts () {
	read -r -p "? " choice
	case $choice in
		"c") pee_check py_check ;;
		"u") update_schmupdate ;;
		"b") install ;;
		"m") making_babies ;;
		"l") line ;;
		"o") load ;;
		"x") exit 0 ;;
		"r") rock ;;
		*) echo -e "${RED}..ERROR..${STD}" && sleep 2
	esac
}
root_check () {
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
update_schmupdate () {
	echo "update schmupdate"
	sleep 1
	$pkg_mngr update || fail_net
}
install () {
	$pkg_mngr install -y $pkgs || fail_net
}

set_ssh () {
	echo "Setting Keys."
	if [[ -e "/home/$user/.ssh" ]]; then
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

pee_check () {
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

py_check () {
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
fail_net () {
	echo 'do something about internet'
	sleep 2
}

ufw_armed () {
	for port in $holes;
	do
		ufw allow $port/tcp;
		echo "$port [+]"
		sleep 1
	done
}

bounce_ssh () {
	service ssh force-restart
	echo "bounced ssh"
	sleep 1
}
bounce_ufw () {
	ufw --force enable
	echo "bounced ufw"
	sleep 1
}
making_babies () {
	if [[ ! -e "/home/$user/.cry" ]]; then
		mkdir /home/$user/.cry
		sleep 1
	else
		echo "already cry'd"
		sleep 1
	fi
		rsync -avp line/* /home/$user/.cry/
		rsync -avp load/*.conf /etc/profile.d/
		echo "babies [+]"
		sleep 1
}
line () {
	set_ssh
	ufw_armed
}
load () {
	echo "load"
}
rock () {
    read -r -p "${1:-Rock and Roll? [y/N]} " response
    case $response in
        [yY][eE][sS]|[yY])
            true
						bounce_ufw
						bounce_ssh
						echo "bounced [+]"
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


root_check
trap '' SIGINT SIGQUIT SIGTSTP
while true
do
	show_menus
	opts
done
