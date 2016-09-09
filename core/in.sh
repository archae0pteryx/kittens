#!/bin/bash
#
# @archae0pteryx
./core/checks.sh
./core/ups.sh
./ins/in_base.sh
./ins/in_db.sh
./ins/in_net.sh
./ins/in_srv.sh
./sets/set_ssh.sh
./sets/set_ufw.sh
./sets/set_user.sh
