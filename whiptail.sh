#!/bin/bash

if (whiptail --title "Rock Defaults?" --yesno "(Rock) Run all scripts" 10 60) then
    ./runall.sh
  else
    exit 0
fi

OPTION=$(whiptail --title "Kittens" --menu "What to do?" 15 60 4 \
"1" "Instructions" \
"2" "Rock Defaults" \
"3" "Guided Selection"
"4" "Install Base Packages only" \
"5" "Set user and ssh only" \
"6" "Exit Kittens" 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $OPTION = 1 ]; then
    ./core/instructions.sh
elif [ $OPTION = 2]; then
    ./core/.sh
fi





PASSWORD=$(whiptail --title "Test Password Box" --passwordbox "Enter your password and choose Ok to continue." 10 60 3>&1 1>&2 2>&3)

exitstatus=$?
if [ $exitstatus = 0 ]; then
    echo "Your password is:" $PASSWORD
else
    echo "You chose Cancel."
fi
