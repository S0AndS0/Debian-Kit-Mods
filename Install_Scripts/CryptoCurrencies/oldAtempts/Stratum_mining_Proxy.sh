#!/bin/bash
PATH=/bin:/usr/bin:/usr/local/bin ; export PATH 
umask 022
bcP_nameScript=Stratum_mining_Proxy.sh
# auto variables
 : ${USER?} ${HOME?} 
# find the name of this script and store it to a variable
bcP_fullScriptPath="$(readlink -f $0)"
# deleat last componit from ThisScript and store to another variable
bcP_ScriptDirectory="$(dirname $bcP_fullScriptPath)"
# web addresses
sourceDownload=https://github.com/slush0/stratum-mining-proxy/tarball/master
gitDownload=git://github.com/slush0/stratum-mining-proxy.git
# set functions
setDownload_Directory () { 
	echo "Use - home - to download to : $HOME"
	echo "Use - download - to download to : $HOME/Download"
	echo "Use - here - to download to : $bcP_ScriptDirectory"
	echo -n "Input the directory you wish to use: "
	read ui_setDownload_Directory
	if [ $ui_setDownload_Directory = home ]
	then
		ui_Download_Directory=$HOME
		echo "$ui_Download_Directory"
	elif [ $ui_setDownload_Directory = download ]
	then 
		mkdir -p $HOME/Download
		ui_Download_Directory=$HOME/Download
		echo "$ui_Download_Directory"
	elif [ $ui_setDownload_Directory = here ]
	then 
		ui_Download_Directory=$bcP_ScriptDirectory
		echo "$ui_Download_Directory"
	else [ $ui_setDownload_Directory = * ]
		echo "Invalid input recived, exiting now..."
		exit
	fi
} 
promptTo_continue () { 
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
promptToSet_aptgetSudo () { 
read -r -p "Are you running as root right now? [Y/n]" response
case "$response" in
	[yY][eE][sS]|[yY])
 # if yes, use apt-get for installs
 		ui_aptgetSudo="apt-get"
 		echo "$ui_aptgetSudo"
		;;
	*)
 #		 Otherwise use sudo apt-get for installs..
	ui_aptgetSudo="sudo apt-get"
	echo "$ui_aptgetSudo"
	;;
esac
} 
downloadSource () { 
	cd $ui_Download_Directory
	wget $sourceDownload
	tar xf slush0-stratum-mining_proxy*.tar.gz
	cd $ui_Download_Directory/slush0-stratum-mining_proxy*
	sudo python setup.py install
	./mining_proxy.py
}
downloadGit () { 
	cd $ui_Download_Directory
	git clone $gitDownload
	cd $ui_Download_Directory/stratum-mining-proxy
	python distribute_setup.py
	python setup.py develop
	./mining_proxy.py
} 
aptDependancies () { 
	$ui_aptgetSudo -y install python-dev libssl-dev
} 
readme () { 
	echo "This script was made posible thanks to the following links:"
	echo "https://github.com/slush0/stratum-mining-proxy"
	echo "By default you will be connected to : Slush's pool interface."
	echo "Input \"./mining_proxy.py --help\" to change this."
} 
# script start
readme
promptTo_continue
setDownload_Directory
promptToSet_aptgetSudo
aptDependancies
echo "Input - source - to download : $sourceDownload"
echo "Input - git - to download : $gitDownload"
echo -n "Input your choice now : "
read ui_Download
if [ $ui_Download = source ]
then
	downloadSource
elif [ $ui_Download = git ]
then 
	downloadGit
else [ $ui_Download = * ]
	echo "Invalid input recived, exiting now..."
	exit
fi
echo "End of script, exiting now..."
exit
# script end
