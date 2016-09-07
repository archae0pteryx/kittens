#!/bin/bash
#
# @archae0pteryx

command -v openvpn >/dev/null 2>&1 || apt update && apt install openvpn easy-rsa
make-cadir ~/openvpn-ca
#cd ~/openvpn-ca
sed -i 's/KEY_COUNTRY="US"/KEY_COUNTRY="US"/g' ~/openvpn-ca/vars
sed -i 's/KEY_PROVINCE="CA"/KEY_PROVINCE="OR"/g' ~/openvpn-ca/vars
sed -i 's/KEY_CITY="SanFrancisco"/KEY_CITY="Portland"/g' ~/openvpn-ca/vars
sed -i 's/KEY_ORG="Fort-Funston"/KEY_ORG="SomeORG"/g' ~/openvpn-ca/vars
sed -i 's/KEY_EMAIL="me@myhost.mydomain"/KEY_EMAIL="ryan@myvagina.in"/g' ~/openvpn-ca/vars
sed -i 's/KEY_OU="MyOrganizationalUnit"/KEY_OU="UnitUnit"/g' ~/openvpn-ca/vars
