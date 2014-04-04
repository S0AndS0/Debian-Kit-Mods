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
OsNode_filePath=$OsICN_ScriptDirectory/OpenStack
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
# script start
echo "This script : $OsI_nameScript : can be used to start the following scripts under : $OsNode_filePath : file path"
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

