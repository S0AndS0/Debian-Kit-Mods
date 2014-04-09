# auto
IP_inet_addr=`/sbin/ifconfig | grep -E 'inet addr' | grep -v '127.0.0.1' | awk '{gsub("addr:",""); print $2}'`
IP_Bcast_addr=`/sbin/ifconfig | grep -E 'Bcast' | grep -v '127.0.0.1' | awk '{gsub("Bcast:",""); print $3}'`
IP_Mask_addr=`/sbin/ifconfig | grep -E 'Mask' | grep -v '127.0.0.1' | awk '{gsub("Mask:",""); print $4}'`
IP_inet6_addr=`/sbin/ifconfig | grep -E 'inet6 addr' | grep -v '127.0.0.1' | grep -v '1/128' | awk '{gsub("addr:",""); print $2}'`
IP_local=`/sbin/ifconfig | grep -E 'inet addr' | grep -E '127.0.0.1' | awk '{gsub("addr:",""); print $2}'`
IP_exteral=`wget -q -O - checkip.dyndns.org | sed -e 's/.*Current IP Address: //' -e 's/<.*$//'`
trimIP=`$IP_Bcast_addr | sed 's/...$//'`
trimRoute=`route -n | grep -E 'UG' | awk '{print $2}'`
IPmin=1
IPmax=254
customPinger=`for ip in $(seq $IPmin $IPmax) ;do (ping -c 1 -w 5 $trimIP$ip >/dev/null && echo "$trimIP$ip" &) ; done`
fLive_IPs=`$customPinger | grep -v '$trimRoute' | grep -v '$IP_inet_addr'`


# userset


