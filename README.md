Debian-Kit-Mods
===============

Scripts and methods of modifying ARM Linux distributions made available by Debian Kit for rooted Android devices will be uploaded here for others to quickly enable new features in their devices.
These scripts should work for any armel Linux distrobution based on debian.

test results
~~~~~~
02152014 ARM_Java_JDK7_Istaller works again.
~~~~~~
usage instructions
~~~~~~
for ARM_Java_JDK7_Istaller 
	clone this github projects to a directory, such as a Downloads folder
	~~~~~
	cd /home/Downloads
	git clone https://github.com/S0AndS0/Debian-Kit-Mods
	~~~~~
	then run the ARM_Java_JDK7_Istaller script with
	~~~~~
	sh /home/Downloads/Debian-Kit-Mods/ARM_Java_JDK7_Istaller
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
	 
~~~~~~

