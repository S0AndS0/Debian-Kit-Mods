Debian-Kit-Mods
===============

Scripts and methods of modifying ARM Linux distributions made available by Debian Kit for rooted Android devices will be uploaded here for others to quickly enable new features in their devices.
These scripts should work for any armel Linux distrobution based on debian.

These scripts where written under the following usernames"
S0AndS0
	XDA and Maptools forums
	http://forum.xda-developers.com/showthread.php?t=2240397
	http://forums.rptools.net/viewtopic.php?f=12&t=24082&start=0
Michael NA
	 Google
To automate and make easy the processes of installing Java from source or tarball and Java dependent software.
Such as Maptools and jMonkey which wouldn't normally be able to run on ARM CPUs. But running Linux on Raspberry Pi or Android mobile devices bypasses much or all the nead to re-write a program to run happielly on ARM.

Modification instructions can be found under the "docs" directory.

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
03142014 findNetworking_IPs can now be used to learn about scripting for bash. Spicificly setting complex variables, saving and renaming and sending files, soon there will be a Part 3 to this script for sending files to a remote device.
	note this is to be viewed running in a terminal window and a text editing window so you can see everything that is happening and being referanced.
	note also that this is a test of "Scripting Lessions for Linux" searies that I plan on putting togeather in the Examples directory so people that are new to Linux and/or running Linux on Android may quickly benofit from the years of testing/learning I've done. I plan to orginize these into fully functional and usefull scripts that step the user (you the reader) through what is going on step-by-step so that the commands are understood enough that you can feel comfortable with modifying/playing-around with the examples for your own uses.
	Mainly this is because I only found one truely fantastic source of information on the main subject of this script but that was through the "way back" machien and though it was a good recource I believe this script will do a good job of introducing people to scripting for themself. And sometimes I too nead a refresher on what can be done with the command line on Linux and how much fun it can be when things just work :-D
	
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
for findNetworking_IPs
	~~~~~
	Read the prompts as they pop up and hit : y : to continue to the next part when done reading about the previous part.
	Read the script in a text editer wile it is running to see how some of the things that are not discribed work.
	Write your own script for your own perpiouses and enjoy.
~~~~~~


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
for ARM_Bramble_Installer
sources of information and scripts
http://westcoastlabs.blogspot.co.uk/2012/06/parallel-processing-on-pi-bramble.html
source of "IP_LOCAL=$(/sbin/ifconfig | sed -n '2 p' | awk '{print $3}')" command
http://www.htmlstaff.org/ver.php?id=22346
for more like the above command
http://stackoverflow.com/questions/6829605/putting-ip-address-into-bash-variable-is-there-a-better-way
for awk commands
http://www.cyberciti.biz/faq/howto-delete-word-using-sed-under-unix-linux-bsd-appleosx/
for grep commands
http://superuser.com/questions/537619/grep-for-term-and-exclude-another-term
for modifide example of IP_Local variable setting
http://bash.cyberciti.biz/misc-shell/read-local-ip-address/
	~~~~~~
for findNetworking_IPs script in Examples directory
for date and time stamp and setting to variables
http://www.cyberciti.biz/faq/linux-unix-formatting-dates-for-display/
for scp examples
http://www.folkstalk.com/2012/07/scp-command-examples-linux-unix.html
for finding the ip of a remote server
http://superuser.com/questions/602674/ping-server-domain-and-capture-its-ip-on-linux
for finding ip's in a range on the same network
http://stackoverflow.com/questions/733418/how-can-i-write-a-linux-bash-script-that-tells-me-which-computer-are-on-in-my-la
for complex netstat command
http://www.commandlinefu.com/commands/view/12407/netstat-list-out-remote-ips-connected-to-server-only
for getting some understanding of what netstat outputs
http://stackoverflow.com/questions/20882/how-do-i-interpret-netstat-a-output
and a lingthy guide to netstat
http://www.dti.ulaval.ca/webdav/site/sit/shared/Librairie/di/operations/informatique/windows/netstat_results.htm
for trimming strings
http://www.shellhacks.com/en/Removing-First-and-Last-Characters-From-Strings-in-Bash
for more trimming string expmples
http://stackoverflow.com/questions/3323809/unix-shell-scripting-trim-last-3-characters-of-a-line-without-using-sed-or-pe
for ls examples
http://www.tecmint.com/15-basic-ls-command-examples-in-linux/

	~~~~~~
	for 2nd_debSetup
	setting user responces to variables on Android shell
http://stackoverflow.com/questions/16705213/android-shell-script-read
	for list of Android spicific shell commands
https://github.com/jackpal/Android-Terminal-Emulator/wiki/Android-Shell-Command-Reference
	for starting an app from the command line on Android
http://stackoverflow.com/questions/5494764/how-to-run-a-specific-android-app-using-terminal
	for scp command examples
http://www.tecmint.com/scp-commands-examples/
	for ssh command examples
http://www.folkstalk.com/2012/07/ssh-command-examples-unix-linux.html?m=1
	for example file not found
http://stackoverflow.com/questions/638975/how-do-i-tell-if-a-file-does-not-exist-in-bash
more examples at
http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_07_01.html
	fast custom pinger. Set : $IPmin $IPmax : and : $trimIP : with help from examples in this script or set manualy with litiral numbers. Note true min is "1" and true max is "254" if setting manualy.
	customPinger=`for ip in $(seq $IPmin $IPmax) ;do (ping -c 1 -w 5 $trimIP$ip >/dev/null && echo "$trimIP$ip" &) ; done`
	source of winning example
http://stackoverflow.com/questions/14038606/fastest-way-to-ping-a-network-range-and-return-responsive-hosts
	for functions quickly/clearly explained
http://stackoverflow.com/questions/6212219/passing-parameters-to-a-bash-function
	for sed and related command examples
http://unix.stackexchange.com/questions/78306/sh-and-grep-numbers-only
http://www.thegeekstuff.com/2009/11/unix-sed-tutorial-append-insert-replace-and-count-file-lines/
http://www.thegeekstuff.com/2009/10/unix-sed-tutorial-advanced-sed-substitution-examples/
http://www.unix.com/shell-programming-scripting/53476-can-sed-substitute-word-specific-line.html
	for positinal peramiters
http://www.thegeekstuff.com/2010/05/bash-shell-positional-parameters/

~~~~~~
