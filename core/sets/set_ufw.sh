for port in $holes;
do
  ufw allow $port/tcp;
  echo "$port [+]"
  sleep 1
done
