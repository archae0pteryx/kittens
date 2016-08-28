#!/bin/bash
# doctl compute droplet create monkies --region sfo1 --image ubuntu-16-04-x64	--size 512mb --ssh-keys fb:86:91:f8:a8:d2:76:39:dd:bb:61:3d:a4:13:97:fa
# git clone https://github.com/archae0pteryx/kittens.git

user='xenu'
password='0000000'
pub_key='0000000.pub'
email='kittens@mailinator.com'
pkg_mngr='apt-get'
pkg_base='vim-nox git python3 '
pkg_net='nethogs'
pkg_srv='apache2 python-letsencrypt-apache php libapache2-mod-php php-mcrypt php-mysql'
pkg_db='mariadb-server'
db_r_pw='0000000'
m_0='idi0t'
salt='0x0x0x0'

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
  echo "(p)ermissions reset"
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
		"i") install_base ;;
    "p") perms ;;
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
    sleep 1
	fi
}
update_schmupdate () {
	echo "update schmupdate"
	sleep 1
	$pkg_mngr update || fail_net
}
install_base () {
	$pkg_mngr install -y $pkg_base || fail_net
}
install_net () {
	$pkg_mngr install -y $pkg_net || fail_net
}
install_srv () {
	$pkg_mngr install -y $pkg_srv || fail_net
  bounce_ufw
}

install_db () {
  $pkg_mngr install -y $pkg_db || fail_net
  mysqladmin -u root password $pass
}
perms () {
  chown -R $user:$user /home/$user || return
  echo "chown'd"
  sleep 1
}
make_user () {
  grep -q "$user" /etc/passwd
    if [ $? -eq 0 ]; then
        echo "user exists"
        sleep 1
      return
    fi
    echo "new pass"
    useradd -m -G sudo -s /bin/bash -p $(openssl passwd $pass) $user
    chown -R $user:$user /home/$user
    pause
}

set_ssh () {
  echo "Setting Keys."
	if [[ -e "/home/$user/.ssh" ]]; then
		echo "ssh folder exists"
    read -r -p "${1:-Remove? [y/N]} " response
      case $response in
        [yY][eE][sS]|[yY])
            true
            rm -rf /home/$user/.ssh
            dir_nonsense
            ;;
        *)
            false
            echo "okie. not removing squat"
            sleep 1
            ;;
      esac
    else
      dir_nonsense
  fi
  echo "im outta the if!"
  sleep 2
}
dir_nonsense () {
  echo "mkdir"
  mkdir /home/$user/.ssh || echo "cant make ssh folder"
  sleep 1
  #touch /home/$user/.ssh/authorized_keys || echo "cant touch ssh"
  echo "echo key"
  touch /home/$user/.ssh/authorized_keys
  cat $pub_key > /home/$user/.ssh/authorized_keys || echo "cant cat auth_keys"
  echo "Dolphinately?"
  sleep 1
  cat /home/$user/.ssh/authorized_keys
  echo "adjusting config / removing root login"
  sleep 1
  sed -i 's/ServerKeyBits 1024/ServerKeyBits 2048/g' /etc/ssh/sshd_config
  sed -i 's/PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config
  sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config
  sed -i 's/#AuthorizedKeysFile/AuthorizedKeysFile/g' /etc/ssh/sshd_config
  echo "done adjusting."
  sleep 1
  echo "chowning"
  chown -R $user:$user /home/$user/.ssh
  chmod 700 /home/$user/.ssh
  chmod 600 /home/$user/.ssh/authorized_keys
  echo "chowned"
  pause 2
}
pub_check () {
	pub=$pub_key
	if [[ ! -e $pub ]]; then
			echo "no ssh key.pub"
			sleep 2
		else
			echo "key [+]"
			sleep 2
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
bounce_srv () {
  systemctl restart apache2
  echo "bounced apache"
  sleep 1
}

bounce_net () {
  return
}

rock () {
    read -r -p "${1:-Rock? y/n} " response
    case $response in
        [yY][eE][sS]|[yY])
            true
            pub_check
            #py_check
            update_schmupdate
            install_base
            #install_net
            install_db
            install_srv
            make_user
            set_ssh
            set_ufw
            echo "fin."
            sleep 3
            reboot
            ;;
        *)
            false
						echo 'bad'
            ;;
    esac
}

clear
root_check
#trap '' SIGINT SIGQUIT SIGTSTP
while true
do
	show_menus
	opts
done
