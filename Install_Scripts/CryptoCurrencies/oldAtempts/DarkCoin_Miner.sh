#!/bin/bash
PATH=/bin:/usr/bin:/usr/local/bin ; export PATH 

echo "___setting_variables"
# Variables
 : ${USER?} ${HOME?}
# find the name of this script and store it to a variable
cpuM_fullScriptPath="$(readlink -f $0)"
# delete last component from ThisScript and store to another variable
cpuM_ScriptDirectory="$(dirname $cpuM_fullScriptPath)"
fBatteryTemp="$(dmesg | grep -E 'BATT' | sed -e 's/\(.*\)\(Temp:\) //p' | tail -1 | awk '{print $1}')"

sourceDownload_cpuminer="https://github.com/ig0tik3d/darkcoin-cpuminer-1.2c"
default_cpuM_threadCount="1"
default_cflag="-O3"


# functions user prompts
echo "___setting_functions"
promptTo_continue () {
read -r -p "Are you sure? [Y/n]" response
case "$response" in
[yY][eE][sS]|[yY])
 # if yes, then start risking changes
;;
*)
 # Otherwise exit..
echo "Try again? exiting.."
exit
;;
esac
}
setUserAcount_settings () {
echo -n "Input the address to the miner pool you wish to use"
read ui_mineAddress
echo -n "Input your $mineAddress worker's username : "
read ui_mineAddress_username
echo -n "Input your $mineAddress port [default was 8332] : "
read ui_mineAddress_port
echo -n "Input your $ui_mineAddress_username password : "
read ui_mineAddress_password
}

setDownload_Directory () {
echo "Use - home - to download to : $HOME"
echo "Use - download - to download to : $HOME/Download"
echo "Use - here - to download to : $cpuM_ScriptDirectory"
echo -n "Input the directory you wish to use: "
read ui_setDownload_Directory
if [ $ui_setDownload_Directory = home ]
then
ui_Download_Directory="$HOME"
mkdir -p $ui_Download_Directory
echo "$ui_Download_Directory"
elif [ $ui_setDownload_Directory = download ]
then
mkdir -p $HOME/Download
ui_Download_Directory="$HOME/Download"
mkdir -p $ui_Download_Directory
echo "$ui_Download_Directory"
elif [ $ui_setDownload_Directory = here ]
then
ui_Download_Directory="$cpuM_ScriptDirectory/Download"
mkdir -p $ui_Download_Directory
echo "$ui_Download_Directory"
else [ $ui_setDownload_Directory = * ]
echo "Invalid input recived, exiting now..."
exit
fi
}
setMake_Config () {
echo "When using the : make : command to install these programs to your Linux system running : configure : is a must to get the best performance."
echo "I found running configure with : CFLAGS=\"-O3 -mfpu=neon\" : on ARM soft float, prvided by Debian Kit, to work well."
echo "Others have found the following to work for thier systems..."
echo "_________"
echo "on ~ Soft Float"
echo " CFLAGS=\"-O3\""
echo "on ~ Debian 7 armhf - Samsung Galaxy S II, Debian 6 armel myTouch 3G slide"
echo	"CFLAGS=\"-O3 -mfpu=neon\""
echo "ARM Cortex-A9 L2=1MiB Linaro Ubuntu LIB-12.09.6A, Freescale i.MX6 Quad, Sabre-Lite Board"
echo " CFLAGS=\"-O2\""
echo "ARM Cortex-A15 ChrUbuntu 12.04, Samsung Chromebook XE303C12"
echo " CFLAGS=\"-O3 -mfpu=neon-vfpv4\""
echo "You may now choose one of those options. Note that the default is : $default_cflag"
echo "_________"
echo "Input - 1 - to run : ./configure CFLAGS=\"-O3\""
echo "Input - 2 - to run : ./configure CFLAGS=\"-O3 -mfpu=neon\""
echo "Input - 3 - to run : ./configure CFLAGS=\"-O3 -mfpu=neon-vfpv4\""
echo -n "Please input a number now - "
read ui_cflag
if [ $ui_cflag = 1 ]
then
ui_cflag="-O3"
elif [ $ui_cflag = 2 ]
then
ui_cflag="-O3 -mfpu=neon"
elif [ $ui_cflag = 3 ]
then
ui_cflag="-O3 -mfpu=neon-vfpv4"
else [ $ui_cflag = * ]
ui_cflag="-O3"
echo "Invalid input recived, using defaults..."
fi
echo "configure set to use : $ui_cflag"
}
setOptions_cpuminerRun () {
echo "There are many options that can be set to run and checking : ./minerd -h : is a great way to find more."
echo "For now this script will display the following usefull options..."
echo " -x, --proxy=[PROTOCOL://]HOST[:PORT] connect through a proxy"
echo " -t, --threads=N number of miner threads (default: number of processors)"
echo " -O, --userpass=U:P username:password pair for mining server"
echo ""
echo " -o : pool to connect to"
echo " -u : your worker name in that pool"
echo " -p : password for that worker"
echo ""
echo "How many processores are you using for mining today?"
echo -n "Don't choose more than what your system has [1 2 3..]? "
read ui_cpuM_threadCount
default_cpuM_threadCount=$ui_cpuM_threadCount
echo "A compleat working example bassed off your inputs can be found bellow..."
echo " ./minerd -t $default_cpuM_threadCount -o $mineAddress:$ui_mineAddress_port -u $ui_mineAddress_username -p $ui_mineAddress_password"
} 

androidType_miner () {
if [ $ui_Android_Linux = debiankit ]
then
writeCustom_miningScripts_DebianKit
androidMining_DebianKit
elif [ $ui_Android_Linux = other ]
then
echo "You are responsible for monitoring your own hardware temp."
echo "Use : $screenHeader_sendCommand -X quit : to kill the screen and it's tasks if you notice bad behavior."
# androidMining_chroot
$screenHeader_startScreen
$screenStuffer '$ui_Download_Directory/cpuminer/./minerd -a sha256d -t $default_cpuM_threadCount -o $mineAddress:$ui_mineAddress_port -u $ui_mineAddress_username -p $ui_mineAddress_password -D /n'
else [ $ui_Android_Linux = * ]
echo "You are responsible for monitoring your own hardware temp."
echo "Use : $screenHeader_sendCommand -X quit : to kill the screen and it's tasks if you notice bad behavior."
$screenHeader_startScreen
$screenStuffer '$ui_Download_Directory/cpuminer/./minerd -a sha256d -t $default_cpuM_threadCount -o $mineAddress:$ui_mineAddress_port -u $ui_mineAddress_username -p $ui_mineAddress_password -D /n'
fi
}

dependsInstall_cpuminer () {
$ui_aptgetSudo -yq install automake
$ui_aptgetSudo -yq install pkg-config
$ui_aptgetSudo -yq install gcc
$ui_aptgetSudo -yq install make
$ui_aptgetSudo -yq install libcurl3-gnutls-dev
} 

mine_with_cpuminer () {
cd $ui_Download_Directory
git clone $sourceDownload_cpuminer
cd cpuminer
$ui_conf_autogen.sh
$ui_conf_configure CFLAGS="$ui_cflag"
make
echo "About to start mining using the following in : $ui_screenName"
echo " $ui_Download_Directory/cpuminer/./minerd -a sha256d -t $default_cpuM_threadCount -o $mineAddress:$ui_mineAddress_port -u $ui_mineAddress_username -p $ui_mineAddress_password -D"
promptTo_continue
cd ~
if [ $ui_AndroidNoAndroid = yes ]
then
echo "Checking what type of Android Linux was selected and mining..."
androidType_miner
elif [ $ui_AndroidNoAndroid = no ]
then
echo "You are responsible for monitoring your own hardware temp."
echo "Use : $screenHeader_sendCommand -X quit : to kill the screen and it's tasks if you notice bad behavior."
$screenHeader_startScreen
$screenStuffer '$ui_Download_Directory/cpuminer/./minerd -a sha256d -t $default_cpuM_threadCount -o $mineAddress:$ui_mineAddress_port -u $ui_mineAddress_username -p $ui_mineAddress_password -D /n'
else [ $ui_AndroidNoAndroid = * ]
echo "Invalid input recived, exiting now..."
exit
fi
cd ~
}


