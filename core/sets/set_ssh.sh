echo "Setting Keys..."
sleep 1
if [[ -e "/home/$user/.ssh" ]]; then
  echo "ssh folder exists"
  read -r -p "${1:-Remove? [y/N]} " response
    case $response in
      [yY][eE][sS]|[yY])
          true
          rm -rf /home/$user/.ssh
          ;;
      *)
          false
          echo "okie."
          sleep 1
          ;;
    esac
fi
mkdir /home/$user/.ssh || echo "cant make ssh folder"
touch /home/$user/.ssh/authorized_keys || echo "cant touch ssh"
cat $pub_key > /home/$user/.ssh/authorized_keys || echo "cant cat auth_keys"
cat /home/$user/.ssh/authorized_keys
echo "adjusting config [+]"
sleep 1
sed -i 's/ServerKeyBits 1024/ServerKeyBits 2048/g' /etc/ssh/sshd_config
sed -i 's/PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config
sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config
sed -i 's/#AuthorizedKeysFile/AuthorizedKeysFile/g' /etc/ssh/sshd_config
echo "set ssh [+]"
sleep 1
chown -R $user:$user /home/$user/.ssh
chmod 700 /home/$user/.ssh
chmod 600 /home/$user/authorized_keys
sleep 1
echo "chowned home ssh [+]"
sleep 1
