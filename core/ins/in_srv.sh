#!/bin/bash
#
# @archae0pteryx
source ../vars

$pkg_mngr install -y $pkg_srv || fail_net
