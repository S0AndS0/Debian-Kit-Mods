#!/bin/bash
PATH=/bin:/usr/bin:/usr/local/bin ; export PATH 
umask 022
echo "___setting_variables"
# Variables
 : ${USER?} ${HOME?} 
# find the name of this script and store it to a variable
cpuM_fullScriptPath="$(readlink -f $0)"
# deleat last componit from ThisScript and store to another variable
cpuM_ScriptDirectory="$(dirname $cpuM_fullScriptPath)"
fBatteryTemp="$(dmesg | grep -E 'BATT' | sed -e 's/\(.*\)\(Temp:\) //p' | tail -1 | awk '{print $1}')"

mineAddress="pit.deepbit.net"
default_cpuM_threadCount="1"
default_cflag="-O3"
# note : don't forget to put : /n' : at the end of the line to close the command
screenStuffer=`screen -r $ui_screenName -p 0 -X stuff`
screenHeader_startScreen="$(screen -d -m -S $ui_screenName)"
screenHeader_sendCommand=`screen -r $ui_screenName`
screenTester="$(screen -ls | grep -E 'No Sockets' | awk '{gsub("No","No");print $1$2$3}')"
screenReAtach_Finder="$(screen -ls | grep -E 'Detached' | awk '(gsub("","");print $1)"

# web addresses
sourceInfo_Link=http://linuxclues.blogspot.com/2013/08/cpuminer-build-source-debian-litecoin.html
sourceInfo_Link2=http://www.jerri.de/blog/archives/2006/05/02/scripting_screen_for_fun_and_profit/
sourceInfo_Link3=https://litecoin.info/Mining_hardware_comparison
sourceInfo_Link4=http://www.linuxquestions.org/questions/linux-software-2/how-to-send-a-command-to-a-screen-session-625015/
sourceInfo_Link5=http://stackoverflow.com/questions/19309043/send-a-command-to-a-window-in-a-running-screen-session-from-a-bash-script
sourceDownload_cpuminer=https://github.com/pooler/cpuminer
# functions user prompts
echo "___setting_functions"
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
setUserAcount_settings () { 
	echo -n "Input your $mineAddress worker's username : "
	read ui_mineAddress_username
	echo -n "Input your $mineAddress port [default was 8332] : "
	read ui_mineAddress_port
	echo -n "Input your $ui_mineAddress_username password : "
	read ui_mineAddress_password
}
ui_rootNOroot () { 
read -r -p "Are you running as root right now? [Y/n] " response
case "$response" in
	[yY][eE][sS]|[yY])
 # if yes, use apt-get for installs
 		ui_aptgetSudo="apt-get"
 		ui_conf_="./"
 		ui_teeFile="tee -a"
		;;
	*)
 #		 Otherwise use sudo apt-get for installs..
	ui_aptgetSudo="sudo apt-get"
	ui_conf_="./"
	ui_teeFile="sudo tee -a"
	;;
esac
} 
setDownload_Directory () { 
	echo "Use - home - to download to : $HOME"
	echo "Use - download - to download to : $HOME/Download"
	echo "Use - here - to download to : $cpuM_ScriptDirectory"
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
		ui_Download_Directory=$cpuM_ScriptDirectory
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
	echo "on ~ 						Soft Float"
	echo "	CFLAGS=\"-O3\""
	echo "on ~						Debian 7 armhf - Samsung Galaxy S II, Debian 6 armel myTouch 3G slide"
	echo	"CFLAGS=\"-O3 -mfpu=neon\""
	echo "ARM Cortex-A9 L2=1MiB 	Linaro Ubuntu LIB-12.09.6A, Freescale i.MX6 Quad, Sabre-Lite Board"
	echo "	CFLAGS=\"-O2\""
	echo "ARM Cortex-A15 				ChrUbuntu 12.04, Samsung Chromebook XE303C12"
	echo "	CFLAGS=\"-O3 -mfpu=neon-vfpv4\""
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
	echo "	-x, --proxy=[PROTOCOL://]HOST[:PORT] connect through a proxy"
	echo "	-t, --threads=N number of miner threads (default: number of processors)"
	echo "	-O, --userpass=U:P username:password pair for mining server"
	echo ""
	echo "	-o : pool to connect to"
	echo "	-u : your worker name in that pool"
	echo "	-p : password for that worker"
	echo ""
	echo "How many processores are you using for mining today?"
	echo -n "Don't choose more than what your system has [1 2 3..]? "
	read ui_cpuM_threadCount
	default_cpuM_threadCount=$ui_cpuM_threadCount
	echo "A compleat working example bassed off your inputs can be found bellow..."
	echo "	./minerd -t $default_cpuM_threadCount -o $mineAddress:$ui_mineAddress_port -u $ui_mineAddress_username -p $ui_mineAddress_password"
} 
androidSafties_DebianKit () { 
	echo "If your running this script on Android running Linux with Debian Kit then battery/CPU temp will nead to be monitored by you."
	echo "This script will atempt to help with keeping your battery temp down by killing the screen running cpuminer software and restart the services automaticly when the battery's temp has gone down again."
	echo "To do this the following variable \$fBatteryTemp : $fBatteryTemp : should have an output showing. Continue only if this is true!"
	promptTo_continue
	echo "Your curent battery Tempreture is : $fBatteryTemp"
	echo -n "Please input the max tempreture you want to run this software up to -: "
	read ui_tempretureLevel_Kill
	echo "\$ui_tempretureLevel_Kill set to : $ui_tempretureLevel_Kill"
	echo "If : $fBatteryTemp : greater than : $ui_tempretureLevel_Kill : then : $screenHeader_sendCommand -X quit : will be sent to kill the offending tasks."
	echo "	Then after the tempreture is less than : $ui_tempretureLevel_Kill : then : : and"
	echo "	 $screenHeader_startScreen : and :"
	echo "	 $screenStuffer '$ui_Download_Directory/cpuminer/./minerd -a sha256d -t $default_cpuM_threadCount -o $mineAddress:$ui_mineAddress_port -u $ui_mineAddress_username -p $ui_mineAddress_password -D'"
	echo "	 will be sent to restart the service in the background again."
}
setAndroidNOAndroid () { 
read -r -p "Are you running Linux on Android with Debian Kit right now? [Y/n] " response
case "$response" in
	[yY][eE][sS]|[yY])
 # if yes, use apt-get for installs
 		ui_AndroidNoAndroid=yes
 		echo - "Input : deb : for Debian Kit or input : other : for chroot Linux. -: "
 		read $ui_Android_Linux
 		if [ $ui_Android_Linux = deb ]
 		then 
	 		ui_Android_Linux=debiankit
 			androidSafties_DebianKit
		elif [ $ui_Android_Linux = other ]
		then 
			ui_Android_Linux=other
		fi
		;;
	*)
 #		 Otherwise use sudo apt-get for installs..
	ui_AndroidNoAndroid=no
	;;
esac
} 
androidMining_DebianKit () { 
# examples of power/tempreture monitoring
# 	Modifide from 
#	http://askubuntu.com/questions/417340/how-do-i-lower-the-critical-temperature/417374#417374
	while true;do
		t=$fBatteryTemp
		if [ $t > $ui_tempretureLevel_Kill ] 
		then 
			echo "Temp High : $t"
			echo "Sending the following commands and giving your hardware a 120 second break before checking if services can be restarted"
			$screenHeader_sendCommand -X quit
			screen -wipe
			sleep 120
		elif [ $t < $ui_tempretureLevel_Kill ] 
		then 
			echo "Temp ok : $t"
			if [ $screenTester = NoSocketsfound ]
			then
				echo "Sending the following commands to restart services"
				$screenHeader_startScreen
				$screenStuffer '$ui_Download_Directory/cpuminer/./minerd -a sha256d -t $default_cpuM_threadCount -o $mineAddress:$ui_mineAddress_port -u $ui_mineAddress_username -p $ui_mineAddress_password -D'
				screen -r $screenReAtach_Finder
				echo "You may now re-atach to the screen running your services with : $screenHeader_sendCommand"
			else [ $screenTester = * ]
				echo "Re-ataching to $screenReAtach_Finder"
				screen -r $screenReAtach_Finder
			fi
		fi 
	sleep 60 
	done	
} 
androidMining_chroot () { 
	echo "Dew to the dificulties in cooling off your Android devices; the following will run on a timer, in seconds, set with your values."
	echo -n "Please state : in seconds : how long you wish to run your mining operations before giving your system a break -: "
	read ui_chrootMining_active
	echo -n "Please state : in seconds : how long of a break to give your system from mining -: "
	read ui_chrootMining_break
	$screenHeader_startScreen
	$screenStuffer '$ui_Download_Directory/cpuminer/./minerd -a sha256d -t $default_cpuM_threadCount -o $mineAddress:$ui_mineAddress_port -u $ui_mineAddress_username -p $ui_mineAddress_password -D'
	screen -r $screenReAtach_Finder
	sleep $ui_chrootMining_active
	echo "Sending the following commands and giving your hardware a $ui_chrootMining_break second break before checking if services can be restarted"
	$screenHeader_sendCommand -X quit
	
	
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
screenSetting () { 
	echo "The : screen : command line program will be used to run mining software so mining operations can be controlled."
	echo "You may kill the screen and it's prosesses with : screen -r testName -X quit"
	echo "You may reatach to the screen with : screen -r testName"
	echo "You may detach from a screen with : Ctrl a d : Note for Android terminal one of your volume or function keys will take the place of the : Ctrl : button."
	echo -n "What do you want to name your screen session for mining?"
	read ui_screenName
	echo "$ui_screenName : set for mining"
} 

# functions - fixed and compiled

dependsInstall_cpuminer () { 
	$ui_aptgetSudo -yq install automake
	$ui_aptgetSudo -yq install pkg-config
	$ui_aptgetSudo -yq install gcc
	$ui_aptgetSudo -yq install make
	$ui_aptgetSudo -yq install libcurl3-gnutls-dev
} 
dependsInstall_script () { 
	$ui_aptgetSudo -yq install screen
} 
mine_with_cpuminer () { 
	cd $ui_Download_Directory
	git clone $sourceDownload_cpuminer
	cd cpuminer
	$ui_conf_autogen.sh
	$ui_conf_configure CFLAGS="$ui_cflag"
	make
	echo "About to start mining using the following in : $ui_screenName"
	echo "	$ui_Download_Directory/cpuminer/./minerd -a sha256d -t $default_cpuM_threadCount -o $mineAddress:$ui_mineAddress_port -u $ui_mineAddress_username -p $ui_mineAddress_password -D"
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
writeCustom_miningScripts_DebianKit () { 
	echo "This script being writen to : $ui_Download_Directory/OverEasy.sh : is yours and custum made for you and your system. There is no reason to share this file because it will contain your information for loging into your worker."
	echo ""
	echo '#!/bin/bash
		fBatteryTemp=`dmesg | grep -E \'BATT\' | sed -e \'s/\(.*\)\(Temp:\) //p\' | tail -1 | awk \'{print \$1}\'`
		default_cpuM_threadCount=$default_cpuM_threadCount
		ui_tempretureLevel_Kill=$ui_tempretureLevel_Kill
		cd ~
		while true;do
		t=\$fBatteryTemp
		if (( \$t > \$ui_tempretureLevel_Kill )); then  
			echo "Temp High : \$t"
			echo "Sending the following commands and giving your hardware a 120 second break before checking if services can be restarted"
			$screenHeader_sendCommand -X quit
			sleep 120
		elif (( \$t < \$ui_tempretureLevel_Kill )); then
			echo "Temp ok : \$t"
			echo "Sending the following commands to restart services"
			$screenHeader_startScreen
			$screenStuffer \$\'$ui_Download_Directory/cpuminer/./minerd -a sha256d -t \$default_cpuM_threadCount -o $mineAddress:$ui_mineAddress_port -u $ui_mineAddress_username -p $ui_mineAddress_password -D /n\'
			echo "You may now re-atach to the screen running your services with : $screenHeader_sendCommand"
		fi 
	sleep 60 
	done' $ui_teeFile $ui_Download_Directory/OverEasy.sh
} 
echo "___starting_script"
# script run start
echo "This script was writen for ARM processors running Linux (Debian flavored)"
echo "This running this script un-atended is not advisable eventhough every efort has been taken to prevent hardware damage."
echo "By continuing to use this script you accept sole resposiblity for what happens."
echo "The auther of this script will not accept resposibilty for your desisions."
echo "You have been warned"
echo "~~~Line-29"
#			Line 29 	exit on anything other than "yes/Y"
promptTo_continue
echo "Running a series of prompts to set : install, configure, and make options."
echo "~~~Line-50"
#			set variables for installing and writing files
ui_rootNOroot
echo "~~~Line-67"
#			set temprature monitoring
setAndroidNOAndroid
echo "~~~Line-104"
#			set configure flag options
setMake_Config
echo "~~~Line-80"
#			set directorie to be used for downloads
setDownload_Directory
echo "Running a series of prompts to set : screen, temprature, and mining options."
echo "~~~Line-190"
#			set variables for screen command
screenSetting
echo "~~~Line-43"
#			set options for login with minerd
setUserAcount_settings
echo "~~~Line-138"
#			set options for minerd command
setOptions_cpuminerRun
echo "Running commands to : install, configure, make, and run software. Sit back and enjoy..."
echo "~~~Line-209"
#			install packages that make the rest if this script work
dependsInstall_script
echo "~~~Line-202"
#			install packages that minerd depends on
dependsInstall_cpuminer
echo "~~~Line-212"
#			download and install minerd and start up mining service
mine_with_cpuminer
# script run end
echo "End of script, exiting now..."
exit
# Credits

#	thanks should be given to the following link's auther for writing an easy to follow guide that works on all platforms and for being helpful even after posting :-)
http://linuxclues.blogspot.com/2013/08/cpuminer-build-source-debian-litecoin.html

# examples

http://unix.stackexchange.com/questions/74874/pkill-cant-kill-processes-with-parent-process-id-1
# to kill an unresponcive background task use the following
pkill -SIGKILL minerd
# 	to find tasks to kill use the : ps : or : top : commands

#	minerd options:
# mine with -D (degugging) to show more info
./minerd -o stratum+tcp://stratum.give-me-ltc.com:3334 -u worker -p password -D

-o : pool to connect to
-u : your worker name in that pool
-p : password for that worker

#	The usage options:
-a, --algo=ALGO specify the algorithm to use
-o, --url=URL URL of mining server
-O, --userpass=U:P username:password pair for mining server
-u, --user=USERNAME username for mining server
-p, --pass=PASSWORD password for mining server
--cert=FILE certificate for mining server using SSL
-x, --proxy=[PROTOCOL://]HOST[:PORT] connect through a proxy
-t, --threads=N number of miner threads (default: number of processors)
-r, --retries=N number of times to retry if a network call fails
(default: retry indefinitely)
-R, --retry-pause=N time to pause between retries, in seconds (default: 30)
-T, --timeout=N timeout for long polling, in seconds (default: none)
-s, --scantime=N upper bound on time spent scanning current work when long polling is unavailable, in seconds (default: 5)
--no-longpoll disable X-Long-Polling support
--no-stratum disable X-Stratum support
--no-redirect ignore requests to change the URL of the mining server
-q, --quiet disable per-thread hashmeter output
-D, --debug enable debug output
-P, --protocol-dump verbose dump of protocol-level activities
-S, --syslog use system log for output messages
-B, --background run the miner in the background
--benchmark run in offline benchmark mode
-c, --config=FILE load a JSON-format configuration file
-V, --version display version information and exit.
-h, --help display this help text and exit.

http://webcache.googleusercontent.com/search?q=cache:EiHbDpksWkAJ:https://bitcointalk.org/index.php%3Ftopic%3D55038.0+&cd=1&hl=en&ct=clnk&gl=us
Q: What's the difference between the two available algorithms, scrypt and sha256d?
A: They are completely different proof-of-work algorithms. 
You must use scrypt for Litecoin, and you must use sha256d for Bitcoin. 
The default algorithm is scrypt, 
so for Bitcoin mining you have to specify --algo=sha256d

# example of sed paturn printing
sed -n -e 's/^.*stalled: //p'
someCommand | sed -e 's/BATT: //p'


# for use in this script
	if [ $ui_AndroidNoAndroid = yes ]
	then
		
	elif [ $ui_AndroidNoAndroid = no ]
	then
		
	else [ $ui_AndroidNoAndroid = * ]
		echo "Invalid input recived, exiting now..."
		exit
	fi

# get battery info from : /sys/class/power_supply : directory.
# command from : http://www.cyberciti.biz/faq/linux-laptop-battery-status-temperature/
	ls -l /sys/class/power_supply/BAT0


