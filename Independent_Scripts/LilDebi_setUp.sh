#!/bin/bash
PATH=/bin:/usr/bin:/usr/local/bin ; export PATH 
umask 022 		# Files that the script creates will have 755 permission.
# Thanks to Ian D. Allen, for this tip.
 : ${USER?} ${HOME?} 
 ldS_fullScriptPath="$(readlink -f $0)"
# deleat last componit from this script and store to another variable
ldS_ScriptDirectory="$(dirname $ldS_fullScriptPath)"

echo -n "Are you running as root linux user? "
read yN_root
echo -n "Do you plan to use other scripts in this github clone? "
read yN_dependancies
echo -n "Do you plan on using VNC or Xrdp to reach your GUI? "
read yN_gui

if [ $yN_root = y ]
then
	echo "Running : apt-get update : and : apt-get upgrade : quietly
	apt-get -q update && apt-get -qy upgrade
	echo "Running : apt-get install sudo : to ensure you have that installed"
	apt-get -qy install sudo
elif [ $yN_root = * ]
then
	echo "Please re-start this script under the root Linux user for your system"
	echo exit
fi

if [ $yN_dependancies = y ]
then
	echo "Installing the following list of packages through apt-get"
	echo "dirname, cut, du"
	apt-get -qy install dirname
	apt-get -qy install cut
	apt-get -qy install du
elif [ $yN_dependancies = * ]
then
	echo "That's ok, moving on to other checks..."
fi

if [ $yN_gui = y ]
then
	echo "Installing the following list of packages through apt-get"
	echo "lxde"
	apt-get -qy install lxde
elif [ $yN_gui = * ]
then
	echo "That's ok, moving on to other checks..."
fi


echo exit
