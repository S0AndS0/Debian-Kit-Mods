#!/bin/bash
PATH=/bin:/usr/bin:/usr/local/bin ; export PATH 
umask 022
# Files that the script creates will have 755 permission.
# Thanks to Ian D. Allen, for this tip.
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
# variables auto
# find the name of this script and store it to a variable
osCN_fullScriptPath="$(readlink -f $0)"
# deleat last componit from ThisScript and store to another variable
osCN_ScriptDirectory="$(dirname $osCN_fullScriptPath)"
osComponent_filePath=$osCN_ScriptDirectory/Controller/Components
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




	echo "Create these databases using the following example"
	echo "___________"
	echo "	mysql -u root -p"
	echo ""
	echo "	#mysql>"
	echo ""
	echo "	#Keystone"
	echo "	CREATE DATABASE keystone;"
	echo "	GRANT ALL ON keystone.* TO 'keystoneUser'@'%' IDENTIFIED BY 'keystonePass357';"
	echo ""
	echo "	#Glance"
	echo "	CREATE DATABASE glance;"
	echo "	GRANT ALL ON glance.* TO 'glanceUser'@'%' IDENTIFIED BY 'glancePass357';"
	echo ""
	echo "	#Neutron"
	echo "	CREATE DATABASE neutron;"
	echo "	GRANT ALL ON neutron.* TO 'neutronUser'@'%' IDENTIFIED BY 'neutronPass357';"
	echo ""
	echo "	#Nova"
	echo "	CREATE DATABASE nova;"
	echo "	GRANT ALL ON nova.* TO 'novaUser'@'%' IDENTIFIED BY 'novaPass357';"
	echo ""
	echo "	#Cinder"
	echo "	CREATE DATABASE cinder;"
	echo "	GRANT ALL ON cinder.* TO 'cinderUser'@'%' IDENTIFIED BY 'cinderPass357';"
	echo ""
	echo "	quit;"
	echo "___________"
	echo "Starting : mysql -u root -p : so you can modify as shown"
	mysql -u root -p
	echo "Prompting for Pass'es for latter use"
	echo -n "What have you set for : keystonePass357? "
	read ui_keystonePass
	echo -n "What have you set for : glancePass357? "
	read ui_glancePass
	echo -n "What have you set for : neutronPass357? "
	read ui_neutronPass
	echo -n "What have you set for : novaPass357? "
	read ui_novaPass
	echo -n "What have you set for : cinderPass357? "
	read ui_cinderPass

