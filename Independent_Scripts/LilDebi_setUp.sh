#!/bin/bash
PATH=/bin:/usr/bin:/usr/local/bin ; export PATH 
umask 022 		# Files that the script creates will have 755 permission.
# Thanks to Ian D. Allen, for this tip.
 : ${USER?} ${HOME?} 
 ldS_fullScriptPath="$(readlink -f $0)"
# deleat last componit from this script and store to another variable
ldS_ScriptDirectory="$(dirname $ldS_fullScriptPath)"
lbs_nameScript=LilDebi_setUp.sh
echo "__________________"
echo "Reading out variables to be used latter..."
echo "Your Linux user is : $USER : Your home directory is : $HOME"
echo "The directory that this script lives in is : $ldS_ScriptDirectory"
echo "The name of this script is : $lbs_nameScript"
echo "__________________"
echo -n "Are you using LilDebi app from the Android Marketplace? [y/N] "
read yN_lilDebi
if [ $yN_lilDebi = y ]
then
	echo "Excelent, moving on to user prompts..."
else
	echo "Unfortunetly LilDebi is what this was desigend for..."
	echo exit
	exit
fi
echo "__________________"
echo "Running prompts for what to set up..."
echo "__________________"
echo -n "Are you running as root linux user? [y/N] "
read yN_root
echo -n "Do you plan to use other scripts in this github clone? [y/N] "
read yN_dependancies
echo -n "Do you plan on using VNC or Xrdp to reach your GUI? [y/N] "
read yN_gui
echo "__________________"
echo "Running commands bassed off your inputs..."
echo "__________________"
echo "\$yN_root is set to : $yN_root"
if [ $yN_root = y ]
then
	echo "Running : apt-get update : and : apt-get upgrade : quietly
	apt-get -q update && apt-get -qy upgrade
	echo "Running : apt-get install sudo : to ensure you have that installed"
	apt-get -qy install sudo
else
	echo "Please re-start this script under the root Linux user for your system"
	echo exit
	exit
fi
echo "__________________"
echo "\$yN_dependancies is set to : $yN_dependancies"
echo "__________________"
if [ $yN_dependancies = y ]
then
	echo "Installing the following list of packages through apt-get"
	echo "dirname, cut, du"
	apt-get -qy install wget
	apt-get -qy install dirname
	apt-get -qy install cut
	apt-get -qy install du
else
	echo "That's ok, moving on to other checks..."
fi
echo "__________________"
echo "\$yN_gui is set to : $yN_gui"
echo "__________________"
if [ $yN_gui = y ]
then
	echo "Installing the following list of packages through apt-get"
	echo "lxde"
	apt-get -qy install lxde
else
	echo "That's ok, moving on to other checks..."
fi
echo "__________________"
echo "...end of curently selected mods"
echo "__________________"
echo exit
