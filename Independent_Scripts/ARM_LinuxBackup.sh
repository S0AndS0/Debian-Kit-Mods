#!/bin/bash
PATH=/bin:/usr/bin:/usr/local/bin ; export PATH 
umask 022 
# Files that the script creates will have 755 permission.
# Thanks to Ian D. Allen, for this tip.
# Variables start
: ${USER?} ${HOME?} 
bL_fullScriptPath="$(readlink -f $0)"
bL_ScriptDirectory="$(dirname $bL_fullScriptPath)"
echo "Your curent working directory is : $PWD" 
echo "The directory that this script is stored in is : $bL_ScriptDirectory"

echo "The syntax for excluding directories from backup is : "
echo -n "What directories do you want to exclude?
read ui_excludeDir

echo -n "You may choose : working : or : script : to save or restore backups too. [w/s]? "
read ui_tarDir
if [ $ui_tarDir = w ]
than
tarDir=$PWD 
elif [ $ui_tarDir = s ]
than
tarDir=$bL_ScriptDirectory 
else
exit
fi
echo "\$tarDir set to : $tarDir"

# Variables end

echo "This script will atempt to make a very compact backup of your Linux OS"
{ 
read -r -p "Are you sure? [Y/n]" response
case "$response" in
[yY][eE][sS]|[yY])
# if yes, then start risking changes
;;
*)
#	 Otherwise exit..
echo "Try again? exiting.."
exit 
;;
esac
}

# wrie functions for script

backup () { 
# write a list of all installed packages
dpkg --get-selections | awk '{ ; print $1}' > $tarDir/insalledPackages_backup.log

} 


