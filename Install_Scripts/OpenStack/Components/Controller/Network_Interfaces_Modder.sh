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
# read variables from ShairedVariables.sh and functions from userVariable_Writer
source $osComponent_filePath/Components/Controller/ShairedVariables.sh
source $osComponent_filePath/Components/Controller/userVariable_Writer
# functions for script
promptTo_Write () { 
read -r -p "Are you sure? [Y/n]" response
case "$response" in
	[yY][eE][sS]|[yY])
 # if yes, then start risking changes
		;;
	*)
 #		 Otherwise exit..
	echo "Try again? exiting.."
	exit 
	;;
esac
} 
writeNonExposed () { 
	echo "The following will be writen to : /etc/network/interfaces"
	echo "	auto $ui_networkType"
	echo "	iface $ui_networkType inet static"
	echo "	address $ui_IP_inetaddress"
	echo "	netmask $ui_IP_maskaddress"
	promptTo_Write
	echo 'auto $ui_networkType
	iface $ui_networkType inet static
	address $ui_IP_inetaddress
	netmask $ui_IP_maskaddress' | tee -a /etc/network/interfaces
} 
writeExposed () { 
	echo "	auto $ui_networkType"
	echo "	iface $ui_networkType inet static"
	echo "	address $ui_IP_inetaddress"
	echo "	netmask $ui_IP_maskaddress"
	echo "	gateway $ui_IP_maskaddress"
	echo "	dns-nameservers $ui_IP_dnsaddress"
	promptTo_Write
	echo 'auto $ui_networkType
	iface $ui_networkType inet static
	address $ui_IP_inetaddress
	netmask $ui_IP_maskaddress
	gateway $ui_IP_maskaddress
	dns-nameservers $ui_IP_dnsaddress' | tee -a /etc/network/interfaces
} 
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "Your - inernet IPv4 - is : $IP_inet_addr"
echo "Your - broadcast IP - is : $IP_Bcast_addr"
echo "Your - mask IP - is : $IP_Mask_addr"
echo "Your - internet IPv6 - is : $IP_inet6_addr"
echo "Your - local IP - is : $IP_local"
echo "Your - external IP - is : $IP_exteral"
echo "The - live IPs - on your network are : $fLive_IPs"
echo "to exit \"vi\" editer : press Esc (on Android this is \"volume up\"+\"e\")"
echo "then : Press \" : \" (colon). The cursor should reappear at the lower left corner of the screen beside a colon prompt."
echo "Enter the following:"
echo "	Input - q! - to exit without saving"
echo "	Input - wq - to exit with saving"
echo "Only one NIC should be reachable from the internet."
echo "This is where the customers will access the webinterface horizon.
echo "In the guide eth1 is used. But it could also be a bond interface (bond0) or a vlan (vla100) or both bond0.100."
echo "For my usage I'll be looking to wifi , bluetooth , and USB connection options."
echo "So edit /etc/network/interfaces with some help from the bellow example..."
echo "__________"
echo "Not public available (used for OpenStack management and iscsi)"
echo "__________"
echo "	auto eth0"
echo "	iface eth0 inet static"
echo "	address 10.10.10.51"
echo "	netmask 255.255.255.0"
echo "__________"
echo "For Exposing OpenStack API over the internet If you want to use your controller node as network node as well, you have to add an interface for your floating (public) ip addresses."
echo "	If your floating ip addresses are on the same subnet as your OpenStack API (Horizon), you could use this interface."
echo "__________"
echo "	auto eth1"
echo "	iface eth1 inet static"
echo "	address 192.168.100.51"
echo "	netmask 255.255.255.0"
echo "	gateway 192.168.100.1"
echo "	dns-nameservers 8.8.8.8"
echo "__________"
echo "Input - manual - to run edits with : vi"
echo "Input - wizard - to run edits with questions and responces and have this script fill in the values."
echo "Input - auto - to run edits using the above values (least amount of prompts)"
echo -n "Which would you like to run [manual/wizard]? "
read ui_MorW
if [ $ui_MorW = manual ]
then
	echo "Making a backup of : /etc/network/interfaces : named : /etc/network/interfaces.orig:
	mv /etc/network/interfaces /etc/network/interfaces.orig
	echo "Running edits with : vi : on the following file : /etc/network/interfaces"
	vi /etc/network/interfaces
elif [ $ui_MorW = wizard ]
then
	echo "Making a backup of : /etc/network/interfaces : named : /etc/network/interfaces.orig:
	mv /etc/network/interfaces /etc/network/interfaces.orig
	echo "Setting user input variables..."
	echo "____________________"
	echo -n "Are you connected via ethernet or wifi [e/w]? "
	read ui_networkType
	echo -n "Do you want to expose your OpenStack API over the internet [y/n]? "
	read ui_exposeYN
	echo -n "Input the IP address to use for the address entry [$IP_inet_addr]? "
	read ui_IP_inetaddress
	echo -n "Input the IP address to use for the mask entry [$IP_Mask_addr]? "
	read ui_IP_maskaddress
	echo -n "Input the IP address to use for the gateway entry [$trimRoute]? "
	read ui_IP_gatewayaddress
	echo -n "Input the IP address to use for the dns-nameservers entry [8.8.8.8]? "
	read ui_IP_dnsaddress
	
	if [ $ui_exposeYN = y ]
	then
		ui_writeExposed
	elif [ $ui_exposeYN = n ]
	then	
		ui_writeNonExposed
	else [ $ui_exposeYN = * ]
	echo "Invalid input recived, exiting now..."
	exit
	fi
	echo "____________________"
elif [ $ui_MorW = auto ]
then
	echo "____________________"
	echo -n "Are you connected via ethernet or wifi [e/w]? "
	read ui_networkType
	echo -n "Input the IP address to use for the dns-nameservers entry [8.8.8.8]? "
	read ui_IP_dnsaddress
	echo "____________________"
	echo "Checking user inputs"
	if [ $ui_networkType = e ]
	then
		ui_networkType=eth0
	elif [ $ui_networkType = w ]
	then
		ui_networkType=wlan0
	else [ $ui_networkType = * ]
	echo "Invalid input recieved, exiting now..."
	exit
	fi
	ui_IP_inetaddress=$IP_inet_addr
	ui_IP_maskaddress=$IP_Mask_addr
	ui_IP_gatewayaddress=$trimRoute
	echo "____________________"
	if [ $ui_exposeYN = y ]
	then
		writeExposed
	elif [ $ui_exposeYN = n ]
	then	
		writeNonExposed
	else [ $ui_exposeYN = * ]
	echo "Invalid input recived, exiting now..."
	exit
	fi
	echo "____________________"
elif [ $ui_MorW = exit ]
then
	echo "Exiting now..."
	exit
else [ $ui_MorW = * ]
	echo "Invalid input recieved, exiting now..."
	exit
fi
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "End of script, exiting now..."
exit
