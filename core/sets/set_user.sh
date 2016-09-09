grep -q "$user" /etc/passwd
if [ $? -eq 0 ]; then
    echo "user exists"
    sleep 1
    return
fi

echo "new pass"

useradd -m -G sudo -s /bin/bash -p $(openssl passwd $pass) $user

chown -R $user:$user /home/$user
