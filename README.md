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
02152014 ARM_Java_JDK7_Istaller works again.
02172014 ARM_Maptools_Installer works again.
~~~~~~
usage instructions
~~~~~~
for ARM_Java_JDK7_Istaller 
	clone this github projects to a directory, such as a Downloads folder
	~~~~~
#	cd /home/Downloads
#	git clone https://github.com/S0AndS0/Debian-Kit-Mods
	~~~~~
	then run the ARM_Java_JDK7_Istaller script with
	~~~~~
#	sh /home/Downloads/Debian-Kit-Mods/ARM_Java_JDK7_Istaller
	~~~~~
	follow the prompts and enjoy Java on your Android device
for ARM_Maptools_Installer
	clone this github projects to a directory, such as a Downloads folder
	~~~~~
#	cd /home/Downloads
#	git clone https://github.com/S0AndS0/Debian-Kit-Mods
	~~~~~
	then run the ARM_Maptools_Installer script with
	~~~~~
#	sh /home/Downloads/Debian-Kit-Mods/ARM_Maptools_Installer
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

