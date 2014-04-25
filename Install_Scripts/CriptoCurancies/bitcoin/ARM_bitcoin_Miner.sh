#!/bin/bash
PATH=/bin:/usr/bin:/usr/local/bin ; export PATH 
umask 022
bcM_nameScript=ARM_bitcoin_Miner.sh
# auto variables
 : ${USER?} ${HOME?} 
# find the name of this script and store it to a variable
bcM_fullScriptPath="$(readlink -f $0)"
# deleat last componit from ThisScript and store to another variable
bcM_ScriptDirectory="$(dirname $bcM_fullScriptPath)"
# web addresses
mineAddress=pit.deepbit.net
wgetUSB_True=http://darkgamex.ch/ufasoft/ufasoft_bitcoin-miner-0.32.tar.lzma
wgetUSB_False=https://github.com/jgarzik/cpuminer/archive/master.zip
download_Alternet1=https://github.com/ckolivas/cgminer
download_Alternet2=https://github.com/nwoolls/bfgminer/
# functions
setUserAcount_settings () { 
	echo -n "Input your $mineAddress username : "
	read ui_mineAddress_username
	echo -n "Input your $mineAddress password : "
	read ui_mineAddress_password
	echo -n "Input your $mineAddress port [default was 8332] : "
	read ui_mineAddress_port
} 
setDownload_Directory () { 
	echo "Use - home - to download to : $HOME"
	echo "Use - download - to download to : $HOME/Download"
	echo "Use - here - to download to : $bcN_ScriptDirectory"
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
		ui_Download_Directory=$bcM_ScriptDirectory
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
ui_rootNOroot () { 
read -r -p "Are you running as root right now? [Y/n]" response
case "$response" in
	[yY][eE][sS]|[yY])
 # if yes, use apt-get for installs
 		ui_aptgetSudo="apt-get"
 		ui_conf="./"
 		ui_teeFile="tee -a"
		;;
	*)
 #		 Otherwise use sudo apt-get for installs..
	ui_aptgetSudo="sudo apt-get"
	ui_conf="sudo ./"
	ui_teeFile="sudo tee -a"
	;;
esac
} 
promptToSet_minerInstall () { 
	echo "Please choose one of the following to install to your device"
	echo "Input - 1 - to download and install the following with USB support : $wgetUSB_True"
	echo "Input - 2 - to download and install the following without USB support : $wgetUSB_False"
	echo "Input - 3 - to download and install : $download_Alternet1"
	echo "Input - 4 - to download and install : $download_Alternet2"
	echo -n "Choose now : "
	read ui_minerToDownload
} 
aptMine_depenancies () { 

	echo "Installing known dependancies with -yqq so it is quite..."
	$ui_aptgetSudo -yqq install make autoconf automake
	$ui_aptgetSudo -yqq install curl libjansson-dev libjansson4
	$ui_aptgetSudo -yqq install gcc gawk
	$ui_aptgetSudo -yqq install lzma libpcre3-dev
	$ui_aptgetSudo -yqq install build-essential autoconf automake libtool pkg-config libcurl3-dev libudev-dev
	$ui_aptgetSudo -yqq install build-essential libcurl4-gnutls-dev libjansson-dev uthash-dev libncursesw5-dev libudev-dev libusb-1.0-0-dev libevent-dev libmicrohttpd-dev hidapi

	echo "Installing known dependancies with -yq so it is quite...this may take sometime..."
	$ui_aptgetSudo -yq install make autoconf automake
	$ui_aptgetSudo -yq install curl libjansson-dev libjansson4
	$ui_aptgetSudo -yq install gcc gawk
	$ui_aptgetSudo -yq install lzma libpcre3-dev
	$ui_aptgetSudo -yq install libcurl3

} 
mine_USB_True () { 
	cd $ui_Download_Directory
	wget $wgetUSB_True
	tar --lzma -xvpf ufasoft_bitcoin-miner-0.32.tar.lzma 
	cd ufasoft_bitcoin-miner-0.32 
	$ui_confconfigure 
	make 
	make install 
	./bitcoin-miner -o http://$ui_mineAddress_username:$ui_mineAddress_password@$mineAddress:$ui_mineAddress_port
	cd ~
} 
mine_USB_False () { 
	cd $ui_Download_Directory
	wget $wgetUSB_False
	unzip master.zip
	cd cpuminer-master
	$ui_confautogen.sh 
	CFLAGS="-O3 -Wall -msse2" $ui_confconfigure 
	make 
	make install
	./minerd --url http://$mineAddress:$ui_mineAddress_port --userpass $ui_mineAddress_username:$ui_mineAddress_password
	cd ~
} 
mine_alternet_cgminer () { 
	cd $ui_Download_Directory
	git clone $download_Alternet1
	./autogen.sh
	CFLAGS="-O2 -Wall -march=native" ./configure
	make
	cgminer --help
	cd ~
}
mine_alternet_bfgminer () { 
	cd $ui_Download_Directory
	git clone $download_Alternet2
	./autogen.sh
	./configure --enable-cpumining
	make
	cd ~
} 
repoModder () { 
	echo "Adding wheezy and sid repo so we can grab some packages not normally available"
	echo 'http://ftp.us.debian.org/debian wheezy main contrib non-free
	http://ftp.us.debian.org/debian sid main contrib non-free' | $ui_teeFile etc/apt/sources.list.d/sid.list
	$ui_aptgetSudo update
} 
repoUnModder () { 
	echo "Removing etc/apt/sources.list.d/sid.list now..."
	rm -I etc/apt/sources.list.d/sid.list
	$ui_aptgetSudo update
} 
readMe () { 
	echo "This scipt was made posible thanks to the following links:"
	echo "http://petesblog.net/blog/bitcoin-mining-on-raspberry-pi"
	echo "http://darkgamex.ch/ufasoft/ufasoft_bitcoin-miner-0.32.tar.lzma"
	echo "https://github.com/jgarzik/cpuminer/archive/master.zip"
	echo "https://github.com/ckolivas/cgminer"
	echo "http://www.raspberrypi.org/forums/viewtopic.php?f=30&t=44225"
	echo "The writer of this script will not be held responsable for your actions or results of your actions."
	echo "You are about to endanger your hardware and or network."
	echo "Curently there are no safeties in this script to keep your system from over heating."
	echo "You must monitor your own hardware and network security."
	echo "You have been warned..."
	echo "____________"
	echo "Curently this script is set up to use $mineAddress for task alocation but will one day include others I'm sure."
	echo "Your username, password and other user set variables are not saved by this script but instead used to populate commands used to make connections."
} 
# script start
readMe
promptTo_continue
setUserAcount_settings
ui_rootNOroot
setDownload_Directory
repoModder
aptMine_depenancies
promptToSet_minerInstall
if [ $ui_minerToDownload = 1 ]
then
	mine_USB_True
elif [ $ui_minerToDownload = 2 ]
then
	mine_USB_False
elif [ $ui_minerToDownload = 3 ]
then
	mine_alternet_cgminer
elif [ $ui_minerToDownload = 4 ]
then
	mine_alternet_bfgminer
else [ $ui_minerToDownload = * ]
	echo "Invalid input recived for \$ui_minerToDownload... Exiting now"
	exit
fi
repoUnModder
echo "End of script, exiting now..."
exit
# script end
