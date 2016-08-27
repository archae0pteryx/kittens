#!/bin/bash
user='xenu'
pass='0000000'
email='kittens@mailinator.com'
p_key='0000000.pub'
pkg_mngr='apt-get'
pkg_loc='vim-nox git python3 '
pkg_net='nethogs'
pkg_srv='apache2'
pkg_db='mariadb-server'
db_r_pw='0000000'
m_0='idi0t'
salt_a='0x0x0x0'
salt_b='0000000'
holes='ssh http https'

pause () {
  read -r -p "Press [Enter]" on_press
}

show_menus() {
	clear
	echo ""
  echo "roc(k)"
	echo "(c)heck reqs"
	echo "(u)pgrade"
	echo "(i)nstall core"
  echo "(m)ake user"
  echo "(n)etwork utils"
	echo "(s)erver"
	echo "(d)atabase"
	echo "set ss(h)"
	echo "(f)irewall"
  echo "(r)eset services"
  echo "r(e)boot"
  echo "shu(t)down"
  echo "e(x)it"
}
opts () {
	read -r -p "? " choice
	case $choice in
    "k") rock ;;
		"c") pee_check py_check ;;
		"u") update_schmupdate ;;
		"i") install_loc ;;
    "m") make_user ;;
		"n") install_net ;;
		"s") install_srv ;;
		"d") install_db;;
    "h") set_ssh ;;
    "f") set_ufw ;;
    "r") bounce_ssh && bounce_ufw ;;
    "e") reboot ;;
    "t") shutdown -h now ;;
    "x") exit 0 ;;
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
install_loc () {
	$pkg_mngr install -y $pkg_loc || fail_net
}
install_net () {
	$pkg_mngr install -y $pkg_net || fail_net
}
install_srv () {
	$pkg_mngr install -y $pkg_srv || fail_net
}
install_db () {
  $pkg_mngr install -y $pkg_db || fail_net
  mysqladmin -u root password $pass
}
make_user () {
  useradd -u 1234 -d /home/$user -g $user -p -s /bin/bash $(echo $pass | openssl passwd -1 -stdin) $user
  usermod -aG sudo $user
  pause
}
set_ssh () {
  sed -i 's/ServerKeyBits 1024/ServerKeyBits 2048/g' /etc/ssh/sshd_config
  sed -i 's/PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config
  sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config
  sed -i 's/#AuthorizedKeysFile/AuthorizedKeysFile/g' /etc/ssh/sshd_config
  echo "Setting Keys."
  pause
	if [[ -e "/home/$user/.ssh" ]]; then
		echo 'ssh exists. skipping.'
		pause
	else
		mkdir /home/$user/.ssh
		chmod 700 /home/$user/.ssh
		touch /home/$user/.ssh/authorized_keys
		chmod 600 /home/$user/.ssh/authorized_keys
		cat ${p_key} | /home/$user/.ssh/authorized_keys
		chown -R $user:$user /home/$user/.ssh
		echo "Set Keys... See?"
		sleep 1
		cat /home/$user/.ssh/authorized_keys
		sleep 1
    pause
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

set_ufw () {
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

rock () {
    read -r -p "${1:-Rock and Roll? [y/N]} " response
    case $response in
        [yY][eE][sS]|[yY])
            true
            update_schmupdate
            install_loc
            install_net
            install_db
            install_srv
						bounce_ufw
						bounce_ssh
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
