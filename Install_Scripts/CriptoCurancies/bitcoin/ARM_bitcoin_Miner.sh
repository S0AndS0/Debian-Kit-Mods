#!/bin/bash
PATH=/bin:/usr/bin:/usr/local/bin ; export PATH 
umask 022
bcM_nameScript=ARM_bitcoin_Miner.sh
# auto variables
 : ${USER?} ${HOME?} 
# find the name of this script and store it to a variable
bcM_fullScriptPath="$(readlink -f $0)"
# deleat last componit from ThisScript and store to another variable
bcN_ScriptDirectory="$(dirname $bcN_fullScriptPath)"
# web addresses
mineAddress=pit.deepbit.net
wgetUSB_True=http://darkgamex.ch/ufasoft/ufasoft_bitcoin-miner-0.32.tar.lzma
wgetUSB_False=https://github.com/jgarzik/cpuminer/archive/master.zip
# functions
setUserAcount_settings () { 
	echo -n "Input your $mineAddress username : "
	read ui_mineAddress_username
	echo -n "Input your $mineAddress password : "
	read ui_mineAddress_password
	echo -n "Input your $mineAddress port [default was 8332] : "
	read ui_mineAddress_port
	echo "$ui_mineAddress_username"
	echo "$ui_mineAddress_password"
	echo "$ui_mineAddress_port"
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
		ui_Download_Directory=$bcN_ScriptDirectory
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
promptToSet_aptgetSudo_Var () { 
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
promptToSet_USBorCPU_Var () { 
read -r -p "Will you be using a USB powered coin miner? [Y/n]" response
case "$response" in
	[yY][eE][sS]|[yY])
 # if yes, then start risking changes
 		ui_USBorCPU=USB_True
 		echo "$ui_USBorCPU"
		;;
	*)
 #		 Otherwise exit..
	ui_USBorCPU=USB_False
	echo "$ui_USBorCPU"
	;;
esac
} 
mine_USB_True () { 
	cd $ui_Download_Directory
	wget $wgetUSB_True
	$ui_aptgetSudo install -y --force-yes lzma libpcre3-dev 
	tar --lzma -xvpf ufasoft_bitcoin-miner-0.32.tar.lzma 
	cd ufasoft_bitcoin-miner-0.32 
	./configure 
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
	$ui_aptgetSudo install -y --force-yes curl libjansson-dev libjansson4 automake autoconf
	./autogen.sh CFLAGS="-O3 -Wall -msse2"
	./configure 
	make 
	make install
	./minerd --url http://$mineAddress:$ui_mineAddress_port --userpass $ui_mineAddress_username:$ui_mineAddress_password
	cd ~
} 
readMe () { 
	echo "This scipt was made posible thanks to the following links:"
	echo "http://petesblog.net/blog/bitcoin-mining-on-raspberry-pi"
	echo "http://darkgamex.ch/ufasoft/ufasoft_bitcoin-miner-0.32.tar.lzma"
	echo "https://github.com/jgarzik/cpuminer/archive/master.zip"
	echo "The writer of this script will not be held responsable for your actions or results of your actions."
	echo "You are about to endanger your hardware and or network."
} 
# script start
readMe
promptTo_continue
setUserAcount_settings
promptToSet_aptgetSudo_Var
setDownload_Directory
promptToSet_USBorCPU_Var
if [ $ui_USBorCPU = USB_True ]
then
	mine_USB_True
elif [ $ui_USBorCPU = USB_False ]
then
	mine_USB_False
else [ $ui_USBorCPU = * ]
	echo "Invalid input recived for \$ui_USBorCPU... Exiting now"
	exit
fi
echo "End of script, exiting now..."
exit
# script end
