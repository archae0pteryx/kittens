#!/bin/bash
source vars

USER_NAME=$(whiptail --title "You know the drill?" --inputbox "Name the new user" 10 60 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = 0 ]; then
    greq -q "$USER_NAME" /etc/passwd
    if [ $? -eq 0 ]; then
      if (whiptail --title "WHOOPS!" --yesno "User exists!" 10 60) then
          ./set_user.sh
        else
          ./whiptail.sh
      fi
else
    ./whiptail.sh
fi


grep -q "$user" /etc/passwd
if [ $? -eq 0 ]; then
    echo "user exists"
    sleep 1
    return
fi

echo "new pass"

useradd -m -G sudo -s /bin/bash -p $(openssl passwd $pass) $user

chown -R $user:$user /home/$user
