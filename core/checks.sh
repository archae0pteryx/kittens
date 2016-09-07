if [[ "$EUID" -ne 0 ]]; then
  echo "root! [-]"
  sleep 1
else
  echo "root [+]"
fi

pub=$pub_key
if [[ ! -e $pub ]]; then
    echo "no key"
    sleep 1
  else
    echo "key [+]"
    sleep 1
    cat $pub
fi
# command -v python3 >/dev/null 2>&1 || "Python3 [-]";
pp='/usr/bin/python3'
if [[ ! -e $pp ]]; then
    echo "Python3 [-]"
    sleep 1
  else
    echo "python3 [+]"
    sleep 1
fi
