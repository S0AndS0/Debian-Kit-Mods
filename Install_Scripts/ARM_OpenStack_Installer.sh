#!/bin/bash
PATH=/bin:/usr/bin:/usr/local/bin ; export PATH 
umask 022 		# Files that the script creates will have 755 permission.
# Thanks to Ian D. Allen, for this tip.
# variables auto
# find the name of this script and store it to a variable
OsICN_fullScriptPath="$(readlink -f $0)"
# deleat last componit from ThisScript and store to another variable
OsICN_ScriptDirectory="$(dirname $OsICN_fullScriptPath)"
# Script names and location
OsI_nameScript=ARM_OpenStack_Installer.sh
OsCpm_nameScript=ARM_Compute_OpenStack_Node
OsCnt_nameScript=ARM_Controller_OpenStack_Node
OsNtw_nameScript=ARM_Network_OpenStack_Node
OsSft_nameScript=ARM_Swift_OpenStack_Node
OsKsn_nameScript=ARM_Keystone_OpenStack_Configure
OsKfx_nameScript=Key_Fixer.sh
OsPfx_nameScript=PATH_Fixer.sh
OsNode_filePath=$OsICN_ScriptDirectory/OpenStack
OsComponent_filePath=$OsICN_ScriptDirectory/OpenStack/Components
# networking
IP_inet_addr=`/sbin/ifconfig | grep -E 'inet addr' | grep -v '127.0.0.1' | awk '{gsub("addr:",""); print $2}'`
IP_Bcast_addr=`/sbin/ifconfig | grep -E 'Bcast' | grep -v '127.0.0.1' | awk '{gsub("Bcast:",""); print $3}'`
IP_Mask_addr=`/sbin/ifconfig | grep -E 'Mask' | grep -v '127.0.0.1' | awk '{gsub("Mask:",""); print $4}'`
IP_inet6_addr=`/sbin/ifconfig | grep -E 'inet6 addr' | grep -v '127.0.0.1' | grep -v '1/128' | awk '{gsub("addr:",""); print $2}'`
IP_local=`/sbin/ifconfig | grep -E 'inet addr' | grep -E '127.0.0.1' | awk '{gsub("addr:",""); print $2}'`
trimIP=`$IP_Bcast_addr | sed 's/...$//'`
# find other devices on your network
trimRoute=`route -n | grep -E 'UG' | awk '{print $2}'`
IPmin=1
IPmax=254
customPinger=`for ip in $(seq $IPmin $IPmax) ;do (ping -c 1 -w 5 $trimIP$ip >/dev/null && echo "$trimIP$ip" &) ; done`
fLive_IPs=`$customPinger | grep -v '$trimRoute' | grep -v '$IP_inet_addr'`
echo "Warning : These scripts make use of \"upgrade\" commands with apt-get"
echo "The following changes to your system for each script can be found listed bellow:"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "package lists"
echo "__________________________"
echo "For compute node"
echo "added:"
echo "	gplhost-archive-keyring , postfix , ethtool , tcpdump , vlan , ntp , kvm , libvirt-bin , pm-utils , openvswitch-switch , openvswitch-datapath-dkms , neutron-plugin-openvswitch-agent , nova-compute-kvm"
echo "removed:"
echo "	nfs-common , rpcbind"
echo "__________________________"
echo "For controller node"
echo "added:"
echo "	gplhost-archive-keyring , postfix , ethtool , tcpdump , vlan , ntp , mysql-server , python-mysqldb , rabbitmq-server , bridge-utils , keystone , glance , neutron-server , nova-api , nova-cert , novnc , nova-consoleauth , nova-scheduler , nova-novncproxy , nova-doc , nova-conductor , cinder-api , cinder-scheduler , cinder-volume , iscsitarget , open-iscsi , iscsitarget-dkms"
echo "removed:"
echo "	nfs-common , rpcbind"
echo "__________________________"
echo "For network node"
echo "added:"
echo "	gplhost-archive-keyring , postfix , ethtool , tcpdump , vlan , ntp , openvswitch-switch , openvswitch-datapath-dkms , neutron-plugin-openvswitch-agent , neutron-dhcp-agent , neutron-l3-agent , neutron-metadata-agent"
echo "__________________________"
echo "For swift node"
echo "added:"
echo "	openstack-swift , openstack-swift-proxy , openstack-swift-account , openstack-swift-container , openstack-swift-object , memcached"
echo "__________________________"
echo "For keystone"
echo "added:"
echo "	openstack-utils , openstack-keystone , mysql-server"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
# Write shaired functions and operations
part00_readme () { 
	echo "This script was made posible by the following links:"
	echo "https://github.com/reusserl/OpenStack-Install-Guide/blob/master/OpenStack_Havana_Debian_Wheezy_Install_Guide.rst"
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	echo "This script will atempt to make the process of installing and configuring Openstack an easier one."
	echo "Your - inernet IPv4 - is : $IP_inet_addr"
	echo "Your - broadcast IP - is : $IP_Bcast_addr"
	echo "Your - mask IP - is : $IP_Mask_addr"
	echo "Your - internet IPv6 - is : $IP_inet6_addr"
	echo "Your - local IP - is : $IP_local"
	echo "The - live IPs - on your network are : $fLive_IPs"
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	echo "to exit \"vi\" editer : press Esc (on Android this is \"volume up\"+\"e\")"
	echo "then : Press \" : \" (colon). The cursor should reappear at the lower left corner of the screen beside a colon prompt."
	echo "Enter the following:"
	echo "	Input - :q! - to exit without saving"
	echo "	Input - :wq - to exit with saving"
} 
part01_prepareDebian () { 
	echo -n "Are you installing on a PC or Android running Linux [pc/android]? "
	read ui_PCorAndroid
	if [ $ui_PCorAndroid = pc ]
	then
		echo "Adding Havana repositories."
		echo "deb http://havana.pkgs.enovance.com/debian havana main
		deb http://archive.gplhost.com/debian havana-backports main" > /etc/apt/sources.list.d/openstack.list
		echo "adding gplhost key"
		apt-get install -y gplhost-archive-keyring
		echo "adding enovance key"
		wget -qO - http://havana.pkgs.enovance.com/debian/dists/havana/pubkey.gpg | apt-key add -
		apt-key list
		{ 
		read -r -p "Do you have errors with those keys? [Y/n] " response
		case "$response" in
			[yY][eE][sS]|[yY])
		 # if yes, then start risking changes
				echo "Running : $OsComponent_filePath/$OsKfx_nameScript"
				sh $OsComponent_filePath/$OsKfx_nameScript
				;;
			*)
		 #		 Otherwise exit..
			echo "Ok moving on then..."
			;;
		esac
		} 
		echo "Updating and upgrading your system"
		apt-get update && apt-get dist-upgrade -y
	elif [ $ui_PCorAndroid = android ]
	then
		echo "Moving on then..."
	elif [ $ui_PCorAndroid = exit ]
	then
		echo "Exiting now..."
		exit
	else [ $ui_PCorAndroid = * ]
		echo "Invalid input recieved, you should quit and re-run"
	fi
	echo "Prompting for user input for : DNS Resolution : an example is presented bellow."
	echo "_________"
	echo "domain yourdomain.ch"
	echo "nameserver 8.8.8.8"
	echo "nameserver 8.8.4.4"
	echo "_________"
	echo -n "Please input : yourdomain : for : /etc/resolv.conf"
	read ui_domain
	echo -n "Please input a : nameserver : for : /etc/resolv.conf"
	read ui_nameserver
	echo -n "Please input the first : IP : for : /etc/resolv.conf"
	read ui_nameserverIP1
	echo -n "Please input the second : IP : for : /etc/resolv.conf"
	read ui_nameserverIP2
	echo "Backing up original : /etc/resolv.conf : to : /etc/resolv.conf.orig."
	mv /etc/resolv.conf /etc/resolv.conf.orig
	echo 'domain $ui_domain.ch
	$ui_nameserver $ui_nameserverIP1
	$ui_nameserver $ui_nameserverIP2' > /etc/resolv.conf
	echo "Appending : /root/.bashrc : with the following:"
	echo '
	HISTSIZE=1000000
	HISTFILESIZE=9999999
	HISTTIMEFORMAT=(%d.%m.%Y) %H:%M
	export HISTSIZE HISTFILESIZE HISTTIMEFORMAT' >> /root/.bashrc
	echo "Running helper script : $OsComponent_filePath/$OsPfx_nameScript : to prevent errors from popping up..."
	sh $OsComponent_filePath/$OsPfx_nameScript
	echo "Removing Exim and installing Postfix"
	apt-get -y install postfix
	dpkg --purge exim4 exim4-base exim4-config exim4-daemon-light
	echo "Activaing mail forwarding"
	echo -n "Please enter your full email address"
	read ui_email
	echo "root: $ui_email.ch" >>/etc/aliases
	newaliases
	/etc/init.d/postfix reload
	echo "Removing unneeded software"
	dpkg --purge nfs-common rpcbind
	echo "Installing some useful tools"
	apt-get install ethtool tcpdump
	echo "Activating VLAN’s"
	apt-get install vlan
	echo "
	# vlan's
	8021q
	" >> /etc/modules
	modprobe 8021q
	echo "Enabling injection"
	echo "	To enable key-file, network & metadata injection into instances images."
	echo "nbd max_part=65" >> /etc/modules
	modprobe nbd max_part=65
	echo "Installing ntp service"
	apt-get install -y ntp
	echo "	Checking if ntp is working"
	ntpq -pn
} 

# script start
echo "This script : $OsI_nameScript : can be used to start the following scripts under : $OsNode_filePath : file path"
echo "Input - prep - to run preperation for other scripts"
echo "Input - compute - to run : $OsCpm_nameScript"
echo "Input - controller - to run : $OsCnt_nameScript"
echo "Input - network - to run : $OsNtw_nameScript"
echo "Input - swift - to run : $OsSft_nameScript"
echo "Input - keystone - to run : $OsKsn_nameScript"
echo -n "Which would you like to run? "
read ui_nodeInstall
if [ $ui_nodeInstall = compute ]
then
	echo "Starting $OsCpm_nameScript..."
	sh $OsNode_filePath/$OsCpm_nameScript
elif [ $ui_nodeInstall = controller ]
then
	echo "Starting $OsCnt_nameScript..."
	sh $OsNode_filePath/$OsCnt_nameScript
elif [ $ui_nodeInstall = network ]
then
	echo "Starting $OsNtw_nameScript..."
	sh $OsNode_filePath/$OsNtw_nameScript
elif [ $ui_nodeInstall = swift ]
then
	echo "Starting $OsSft_nameScript..."
	sh $OsNode_filePath/$OsSft_nameScript
elif [ $ui_nodeInstall = keystone ]
then
	echo "Starting $OsKsn_nameScript..."
	sh $OsNode_filePath/$OsKsn_nameScript
elif [ $ui_nodeInstall = prep ]
then 
	echo "Running Prep functions contained in this script."
	part00_readme
	part01_prepareDebian
elif [ $ui_nodeInstall = exit ]
then 
	echo "Invalid input recieved, exiting now..."
	exit
else [ $ui_nodeInstall = * ]
then 
	echo "Exiting now..."
	exit
fi
echo "End of script, exiting now..."
exit
# notes and credits
# used PDF from following location
# http://docs.openstack.org/havana/install-guide/install/apt-debian/content/
# fantastic guide bellow
# https://github.com/reusserl/OpenStack-Install-Guide/blob/master/OpenStack_Havana_Debian_Wheezy_Install_Guide.rst

