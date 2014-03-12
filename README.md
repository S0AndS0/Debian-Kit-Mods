Debian-Kit-Mods
===============

Scripts and methods of modifying ARM Linux distributions made available by Debian Kit for rooted Android devices will be uploaded here for others to quickly enable new features in their devices.
These scripts should work for any armel Linux distrobution based on debian.

These scripts where written under the following usernames"
S0AndS0
	XDA and Maptools
Michael NA
	 Google
To automate and make easy the processes of installing Java from source or tarball and Java dependent software.
Such as Maptools and jMonkey which wouldn't normally be able to run on ARM CPUs. But running Linux on Raspberry Pi or Android mobile devices bypasses much or all the nead to re-write a program to run happielly on ARM.
###
# warning of pairale
# This is offered freely and without warranty
# users of these scripts may destroy everything they hold dear.
# security wile running Linux on Android should be conidered like running a full PC. 
# "sudo rm" on the Linux side will do the same as "su rm" irigardless of what directory or permitions.
# So be aware that the OS can be compermized and because the data 
# of the Android device is on the same hardware bothe can be compermized or distroid.
###
test results
~~~~~~
02152014 ARM_Java_JDK7_Istaller works again. (renamed to ARM_JDK7sf_Installer in preperation for other versions for hardfloat to be made)
02172014 ARM_Maptools_Installer works again.
02242014 ARM_Java7_Downloader now exsists and works.
02272014 FindScriptDirectory works as an example of what's to come
03012014 ARM_Linux_Moder now functions to run any of the scripts from this github project
	furthermore; the three new versions of ARM_Java_JDK7_Istaller, ARM_Maptools_Installer, and ARM_Java7_Downloader under the Install_Scripts 
	should all function corectly
03082014 ARM_NodeJS_Installer now works for Debian Kit; use option 3 to install through apt-get.
	note though that installing libc6-dev may kick you out of xrdp and ssh connections temperaraly wile it installs, but after a minuet or two everything will restart and you can reconect.
	options 1 and 2 are still untested as I don't have hard float running right now and the other option is for Pi soft float.
	for NoFlo enthusiest there is a final prompt to request permition to install noflo through npm.
~~~~~~
usage instructions
~~~~~~
##
	clone this github projects to a directory, such as a Downloads folder
	~~~~~
#	cd /home/Downloads
#	git clone https://github.com/S0AndS0/Debian-Kit-Mods
	~~~~~
	then run the ARM_Linux_Moder script with
	~~~~~
#	sh /home/Downloads/Debian-Kit-Mods/ARM_Linux_Moder
	~~~~~
	follow the prompts and choose which source file you wish to have downloaded or installed
##
for ARM_Maptools_Installer
	~~~~~
	follow the prompts and enjoy Maptools on your Android device
	if the shortcut on your desktop does't work for Maptools
	right click the desktop shortcut
	click on properties
	click on the "open with" drop down under the general tab
	click on "custumize" or "choose an application"
	click on the right hand tab "custom comandline"
	input the following in the text diolog
		java -jar
	click on the ok button and give it a second or two to start up.
for Key_Fixer
	~~~~~
	use this to fix any missing keys that maybe causing errors after manualy modifying apt-get's source list.
	~~~~~
~~~~~~

modification instructions
~~~~~~
for ARM_Java_JDK7_Istaller
	lines 49-51 have variales set up to easly modify between jdk versions
	~~~~~~
49	javaVersion=jdk-7u21
50	javaFind=$HOME/Downloads
51	javaShortcutVersion=jdk1.7.0_21
	~~~~~~
	use these to modify the script so that it finds and sets up Java corectly on your device.
	for example, bellow, the sugested modds to the script would change things so java version 7u45 would be installed and find would be pointed to your external sdcard for finding the source .tar file.
	~~~~~~
49	javaVersion=jdk-7u45
50	javaFind=/sdcard/downloads
51	javaShortcutVersion=jdk1.7.0_45
	~~~~~~
for ARM_Maptools_Installer
	lines 23-28 have variables set up to easly modify for different builds of maptools.
	~~~~~~
23	pathFinderversion=MT1.3.87.06_DnD35_Pathfinder.cmpgn
24	MT_buildVersion=maptool-1.3.b87
25	MT_shortcutVersion=maptool-1.3.b87.jar
26	MT_findVersion=maptool
27	MT_downloadVersion=http://www.rptools.net/download/zip/maptool-1.3.b87.zip
28	Download_DnD35_Pathfinder=https://www.sugarsync.com/pf/D356388_6189570_977596?directDownload=true
	~~~~~~
	use thes to download and install the version that your GM is using.
	for example, bellow, the sugested modds the the script would download and install build 89 of maptools instead
	~~~~~~
23	pathFinderversion=MT1.3.87.06_DnD35_Pathfinder.cmpgn
24	MT_buildVersion=maptool-1.3.b89
25	MT_shortcutVersion=maptool-1.3.b89.jar
26	MT_findVersion=maptool
27	MT_downloadVersion=http://www.rptools.net/download/zip/maptool-1.3.b89.zip
28	Download_DnD35_Pathfinder=https://www.sugarsync.com/pf/D356388_6189570_977596?directDownload=true
	~~~~~~
for FindScriptDirectory
	~~~~~
	$ThisScript and $PathTo_ThisScript can be modifide for other uses or encorperation into other scripts.
	if using within a script that writes out its componits such as the ones found in this branch then the following lines;
3	ThisScript="$(readlink -f $0)"
	and
5	PathTo_ThisScript="$(dirname $ThisScript)"
	and
8	echo "The name of this script is : $ThisScript"
9	echo "The path to this script is : $PathTo_ThisScript"
	should be modifide to;
3	ThisScript="\$(readlink -f \$0)"
	and
5	PathTo_ThisScript="\$(dirname \$ThisScript)"
	and
8	echo "The name of this script is : \$ThisScript"
9	echo "The path to this script is : \$PathTo_ThisScript"
	in the "host script" so the variables are not prossessed during the writing out portion.
	This example will be used latter to modify some of the curent scripts and the new ones to come.
	 Perpios of this script example is to save the directory that it is running from into a variable that can be use latter,
	 reason why this is useful; allows script componits to find one another no matter where they may have been downloaded from. 
	~~~~~
~~~~~~

Sources that where used to construct these scripts
~~~~~~
for ARM_Java_JDK7_Istaller
	for Depends_Install_List I compiled this list from
http://www.oracle.com/technetwork/java/javase/downloads/jdk7-downloads-1880260.html
http://www.calxeda.com/trystack/gettingstarted/
http://elinux.org/RPi_Java_JDK_Installation
http://www.savagehomeautomation.com/pi-jdk
	and automated ARM_Java_JDK7_Istaller thanks to 
http://stackoverflow.com/questions/10268583/how-to-automate-download-and-instalation-of-java-jdk-on-linux
	for Alternatives_Install_list I compiled this list from
http://www.calxeda.com/trystack/gettingstarted/
	~~~~~~
for FindScriptDirectory
http://stackoverflow.com/questions/59895/can-a-bash-script-tell-what-directory-its-stored-in
http://www.cyberciti.biz/faq/unix-linux-appleosx-bsd-bash-script-find-what-directory-itsstoredin/
	~~~~~~
for Key_Fixer
http://www.mepis.org/docs/en/index.php?title=Public_key_not_available_error
	~~~~~~
for ARM_NodeJS_Installer
	easy script to cross compile for multiple versions of ARM
https://github.com/itwars/Nodejs-ARM-builder
	for sources of pre-compiled nodejs binaries
https://gist.github.com/adammw/3245130
	~~~~~~
for ARM_Repo_Moder
chef Opscode
# Secure APT - wget -O- http://apt.opscode.com/packages@opscode.com.gpg.key | sudo apt-key add -
# deb http://apt.opscode.com/ stable main
Note you can use the following link to remove repos and their keys
http://www.sourceslist.eu/?download=remove-apt-repository
if you find that you don’t want that repo anymore
Note2 the site is in Italian so use google translate if you need directions
	~~~~~~
for ARM_NoFlo_Installer
sources of information that where helpful in writing this script
for node.js
http://joshondesign.com/2013/10/23/noderpi
for NoFlo
https://plus.google.com/100751105859582805241/posts/iDbvbUJXHsN
for automaticly trying to download node.js if it fails the first time
http://stackoverflow.com/questions/5920333/how-to-check-size-of-a-file
~~~~~~
