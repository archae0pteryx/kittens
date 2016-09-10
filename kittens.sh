#!/bin/bash
#
# @archae0pteryx
if readlink /proc/$$/exe | grep -qs "dash"; then
	echo "This script needs to be run with bash, not sh"
	exit 1
fi

home () {
clear
cat << "EOF"
*****************************************************************************
*                                                                           *
*                                                                           *
*                                                                           *
*                                                                           *
*                                 Kittens                                   *
*                                                                           *
*                                                                           *
*                                                                           *
*                                                                           *
*                                                                           *
*****************************************************************************
________________________________Select Yarn__________________________________

[r]ock (defaults)             [s]sh (set ssh)               [u]pgrade system
[c]reate user                 [b]ase pkg install            [n]et pkg install
[d]atabase pkg install        [f]irewall set                [q]exit script
[v]Server pkg install         [h]elp                        [re]boot
[shut]Shutdown
EOF
echo ""
}

opts () {
	read -r -p ">>" choice
	case $choice in
    "r") /bin/bash core/runall.sh ;;
		#"") ./core/checks.sh ;;
		"u") ./core/ups.sh ;;
		"b") ./core/ins/in_base.sh ;;
    #"p") perms ;;
    "c") ./core/sets/set_user.sh ;;
		"n") ./core/ins/in_net.sh ;;
		"v") ./core/ins/in_srv.sh ;;
		"d") ./core/ins/in_db.sh;;
    "s") ./core/sets/set_ssh.sh ;;
    "f") ./core/sets/set_ufw.sh ;;
    #"r") bounce_ssh && bounce_ufw ;;
    "re") reboot ;;
    "shut") shutdown -h now ;;
    "q") exit 0 ;;
		*) echo -e "${RED}nope. Press [q] if unsure. ${STD}" && sleep 2
	esac
}

while true
do
	home
	opts
done
