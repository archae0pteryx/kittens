#!/bin/bash
#
# @archae0pteryx
source ../vars

$pkg_mngr install -y $pkg_db || fail_net
mysqladmin -u root password $pass
mysql_secure_installation
