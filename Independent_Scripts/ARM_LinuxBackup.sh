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




# examples and credits

# http://www.linuxquestions.org/questions/linux-newbie-8/using-tar-how-to-exclude-list-of-directories-893787/
# exclude directories from tar command with a file that lists the directories to exclude (one per line)
# --exclude-from=/PATH_TO/exclude.txt

# http://www.unix.com/shell-programming-scripting/67831-replace-space-new-line.html
# replace spaces with new line
# tr ' ' '\n' < myFile

