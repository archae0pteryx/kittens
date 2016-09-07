#!/bin/bash
#
# @archae0pteryx

# doctl compute droplet create monkies --region sfo1 --image ubuntu-16-04-x64	--size 512mb --ssh-keys fb:86:91:f8:a8:d2:76:39:dd:bb:61:3d:a4:13:97:fa
# git clone https://github.com/archae0pteryx/kittens.git

user='xenu'
password='0000000'
pub_key='keys/0000000.pub'
pkg_mngr='apt-get'
pkg_base='git python3 curl'
pkg_net='nethogs nmap openvpn easy-rsa'
pkg_srv='apache2 php php-curl php-gd php-mbstring php-mcrypt php-xml php-xmlrpc libapache2-mod-php php-mysql php-cli phpmyadmin'
pkg_db='mysql-server'
db_r_pw='0000000'
salt='0x0x0x0'
holes='ssh http https mysql'

if readlink /proc/$$/exe | grep -qs "dash"; then
	echo "This script needs to be run with bash, not sh"
	exit 1
fi

pause () {
  read -r -p "Press [Enter]" on_press
}

show_menus() {
	clear
	echo ""
  echo "(k)Rock (Defaults)"
	echo "(c)heck reqs"
	echo "(u)pgrade"
	echo "(i)nstall core"
  #echo "(p)ermissions reset"
  echo "(m)ake user"
  echo "(n)etwork utils"
	echo "(s)erver"
	echo "(d)atabase"
	echo "(h)Set ssh"
	echo "(f)irewall"
  #echo "(r)eset services"
  echo "(e)reboot"
  echo "(t)shutdown"
  echo "(x)exit"
}

opts () {
	read -r -p "Select one:" choice
	case $choice in
    "k") rock ;;
		"c") ./core/checks.sh ;;
		"u") ./core/ups.sh ;;
		"i") ./core/ins/in_base.sh ;;
    #"p") perms ;;
    "m") ./core/sets/set_user.sh ;;
		"n") ./core/ins/in_net.sh ;;
		"s") ./core/ins/in_srv.sh ;;
		"d") ./core/ins/in_db.sh;;
    "h") ./core/sets/set_ssh.sh ;;
    "f") ./core/sets/set_ufw.sh ;;
    #"r") bounce_ssh && bounce_ufw ;;
    "e") reboot ;;
    "t") shutdown -h now ;;
    "x") exit 0 ;;
		*) echo -e "${RED}..ERROR..${STD}" && sleep 2
	esac
}

rock () {
    read -r -p "${1:-Rock and Roll? [y/N]} " response
    case $response in
        [yY])
            true
            ./core/ups.sh
            ./core/in.sh
            reboot
            ;;
        *)
            false
						echo 'bad'
            ;;
    esac
}
clear

while true
do
	show_menus
	opts
done
