## Kittens
[![Build Status](https://travis-ci.org/archae0pteryx/kittens.svg?branch=master)](https://travis-ci.org/archae0pteryx/kittens)
> Just as the divine hand of our creator Xenu gropes at our natural world, so too do kittens purr in the ears of our fanciful machines. - _ Plato_

### A script to take care of the "dirty work" involved with initial server setup.

*This script is meant to be run on a fresh Linux install

---
#### Quick - wham, bam, thank you ma'am?
do:

    git clone # then
    chmod +x kittens.sh && ./kittens.sh
---
### What does it do?
Kittens will configure ssh, ufw, openvpn, database, and many other things that make sys admin boring. Throw all of your standard packages in the mix and kittens will create a user, lockdown ssh for key auth only, set ufw rules, update/upgrade, install all the packages and then kindly reboot.

### How the hell do you drive this thing?
1. Select your vars in **core/vars**
2. Gently place your pubic key into the keys folder **core/keys** (a default one is provided)
3. Run script
3. Use "**Rock**" to execute the whole kit-n-kaboodle
 - OR, you can
6. Not "rock" and select only the operations you like from the main menu. s'up'to'you

#### The Future of Kittens:
- ~~Store Globals in json?~~
- An interactive user and key variable setting situation.
- Oh-My-Zsh setup
- Either create or pull .cfg git alias
- OpenVPN setup
- Pass password ahead of time.
- Other pkg mgmt / distro support
- pass to python
- Send certs to email
- Digital Ocean integration *see github.com/archae0pteryx/doit
