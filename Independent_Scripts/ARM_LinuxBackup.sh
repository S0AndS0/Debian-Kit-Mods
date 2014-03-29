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

echo " By default the following directories will be excluded from your Linux backup : proc sys dev/pts backups sdcard : which you can changed before conferming the backup process."
echo -n "What directories do you want to exclude in addition? Just seperate with a space and please do not lead with \"/\" charicter or that directory will still be backed-up. "
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
mkdir -p $tarDir/Backup_Linux

# Variables end

echo "This script will atempt to make a very compact backup of your Linux OS"
{ 
read -r -p "Are you sure? [Y/n] " response
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
	echo "_________"
	echo "Writing default exclusions to : $tarDir/exclude.txt"
	echo 'proc
	sys
	dev/pts
	$tarDir/Backup_Linux
	sdcard' | tee -a $tarDir/exclude.txt
	echo "Adding your exclusions to : $tarDir/exclude.txt"
	$ui_excludeDir | tr ' ' '\n' >> $tarDir/exclude.txt
	echo "_________"
	echo "Writing a list of packages that are curently installed to : $tarDir/insalledPackages_backup.log"
	dpkg --get-selections | awk '{ ; print $1}' > $tarDir/insalledPackages_backup.log
	echo "_________"
	echo "Sending tar commands momenteraly which will make a file in : $tarDir/Backup_Linux"
	echo "You may try using \"crtl+d\" to stop now or do nothing and let the following command run"
	echo "tar -zcvpf \$tarDir/Backup_Linux/linuxbackup.tar.gz --directory=/ --exclude-from=\$tarDir/exclude.txt . " && sleep 5
	tar -zcvpf $tarDir/Backup_Linux/linuxbackup.tar.gz --directory=/ --exclude-from=$tarDir/exclude.txt . 
	
} 




# examples and credits

# http://www.linuxquestions.org/questions/linux-newbie-8/using-tar-how-to-exclude-list-of-directories-893787/
# exclude directories from tar command with a file that lists the directories to exclude (one per line)
# --exclude-from=/PATH_TO/exclude.txt

# http://www.unix.com/shell-programming-scripting/67831-replace-space-new-line.html
# replace spaces with new line
# tr ' ' '\n' < myFile

# http://www.aboutdebian.com/tar-backup.htm
# backup everything but excluded directories to a file named : fullbackup.tar.gz
# tar -zcvpf /backups/fullbackup.tar.gz --directory=/ --exclude=proc --exclude=sys --exclude=dev/pts --exclude=backups .
# restore that backup 
# tar -zxvpf /fullbackup.tar.gz
#+	note when backing up and restoring: 

