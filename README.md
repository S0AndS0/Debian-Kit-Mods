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
	for example, bellow, the sugested modds to the script would point 
	~~~~~~
49	javaVersion=jdk-7u45
50	javaFind=/sdcard/downloads
51	javaShortcutVersion=jdk1.7.0_45
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
	and automated it thanks to 
http://stackoverflow.com/questions/10268583/how-to-automate-download-and-instalation-of-java-jdk-on-linux
	for Alternatives_Install_list I compiled this list from
http://www.calxeda.com/trystack/gettingstarted/
~~~~~~

