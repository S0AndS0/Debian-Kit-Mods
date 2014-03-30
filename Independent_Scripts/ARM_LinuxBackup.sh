#!/bin/bash
PATH=/bin:/usr/bin:/usr/local/bin ; export PATH 
umask 022 
# Files that the script creates will have 755 permission.
# Thanks to Ian D. Allen, for this tip.
# Variables start
bL_fullScriptPath="$(readlink -f $0)"
bL_ScriptDirectory="$(dirname $bL_fullScriptPath)"
echo "Your curent working directory is : $PWD" 
echo "The directory that this script is stored in is : $bL_ScriptDirectory"
echo " By default the following directories will be excluded from your Linux backup : proc sys dev/pts backups sdcard : which you can changed before conferming the backup process."
echo -n "What directories do you want to exclude in addition? Just seperate with a space and please do not lead with \"/\" charicter or that directory will still be backed-up. "
read ui_excludeDir
echo -n "You may choose : working : or : script : to save or restore backups. [w/s]? "
read ui_tarDir
if [ $ui_tarDir = w ]
than
	SorR_tarDir=$PWD 
elif [ $ui_tarDir = s ]
than
	SorR_tarDir=$bL_ScriptDirectory
else
exit
fi
echo "\$tarDir set to : $tarDir"
mkdir -p $SorR_tarDir/Backup_Linux
tarDir=$SorR_tarDir/Backup_Linux

echo -n "Are you running Linux with LilDebi or Debian Kit [l/d]? "
read ui_chOrschRoot

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

excludeList_Populator () { 
	echo "Showing list of all directories under : / : directory"
	cd ~
	ls -a
	if [ $ui_chOrschRoot = l ]
	then
		echo '
		
		' | tee -a $tarDir/exclude.txt
	elif [ $ui_chOrschRoot = d ]
	then
		echo '
		
		' | tee -a $tarDir/exclude.txt
	else [ $ui_chOrschRoot = * ]
	then
		echo "exiting now..."
		exit
	else [ $ui_chOrschRoot = * ]
		echo "Invalid input recieved. Exiting now..."
		exit
	fi
	echo "_________"
	echo "Adding your exclusions to : $tarDir/exclude.txt"
	$ui_excludeDir | tr ' ' '\n' >> $tarDir/exclude.txt
	echo "_________"
	
	
} 


backup_Linux () { 
	echo "Writing a list of packages that are curently installed to : $tarDir/insalledPackages_backup.log"
	dpkg --get-selections | awk '{ ; print $1}' > $tarDir/insalledPackages_backup.log
	echo "_________"
	echo "Writing a file to aid in un-packing your backup when it is needed named : restore.sh"
	echo '#!/bin/bash
	PATH=/bin:/usr/bin:/usr/local/bin ; export PATH 
	umask 022 
	# Files that the script creates will have 755 permission.
	# Thanks to Ian D. Allen, for this tip.
	# Variables start
	bL_fullScriptPath="\$(readlink -f \$0)"
	bL_ScriptDirectory="\$(dirname \$bL_fullScriptPath)"
	echo "Your curent working directory is : \$PWD" 
	echo "The directory that this script is stored in is : \$bL_ScriptDirectory"
	echo -n "You may choose : working : or : script : to save or restore backups. [w/s]? "
	read ui_tarDir
	if [ \$ui_tarDir = w ]
	than
		tarDir=$PWD 
	elif [ \$ui_tarDir = s ]
	than
		tarDir=\$bL_ScriptDirectory 
	else
	exit
	fi
	echo "\$tarDir set to : \$tarDir"
	echo "About to restore your system from : \$tarDir/Backup_Linux/"
	{ 
		read -r -p "Are you sure? [Y/n] " response
		case "\$response" in
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
	echo "_________"
	for packageName in `cat \$tarDir/insalledPackages_backup.log`
	do
		echo "Running : apt-get install \$packageName"
		apt-get install \$packageName
	done
	echo "_________"
	echo "Restore should now be compleat"
	echo "exiting now..."
	exit' | tee -a $tarDir/restore.sh
	echo "_________"
	echo "Sending tar commands momenteraly which will make a file in : $tarDir/Backup_Linux"
	echo "You may try using \"crtl+d\" to stop now or do nothing and let the following command run which may take some time to compleat"
	echo "tar -zcvpf \$tarDir/Backup_Linux/linuxbackup.tar.gz --directory=/ --exclude-from=\$tarDir/exclude.txt . " && sleep 5
	tar -zcvpf $tarDir/Backup_Linux/linuxbackup.tar.gz --directory=/ --exclude-from=$tarDir/exclude.txt . 
	echo "_________"
	echo "should be done, now you may transfer : linuxbackup.tar.gz : to another device for safe keeping."
	ls $tarDir/Backup_Linux
} 
restore_Linux () { 
	echo "_________"
	cd /
	echo "Reading default directory for files to restore..."
	ls $tarDir
	echo "Reading : Backup_Linux : directory for tar file"
	zgrep $tarDir/linuxbackup.tar.gz | ls 
	echo "_________"
		{ 
		read -r -p "Do we have the following files : restore.sh , insalledPackages_backup.log : and directory : Backup_Linux? [Y/n] " response
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
	echo "_________"
	echo "Proceeding with restore..."
	tar -zxvpf $tarDir/Backup_Linux/linuxbackup.tar.gz
	sh restore.sh
	echo "_________"
}
# start of script
echo "This script should be run under your root user on a Linux terminal"
echo "Input - backup - to backup to : $tarDir/Backup_Linux/linuxbackup.tar.gz"
echo "Input - restore - to restore to the : / : directory from : $tarDir/linuxbackup.tar.gz"
echo "Input - exit - to : exit : and not perform any actions"
echo -n "Which opperation do you wish to perform? "
read ui_BorR
if [ $ui_BorR = backup ]
then
	echo "Writing default exclusions to : $tarDir/exclude.txt"
	excludeList_Populator
	
	backup_Linux
elif [ $ui_BorR = restore ]
then
	restore_Linux
elif [ $ui_BorR = exit ]
then
	echo "Exiting now..."
	exit
else [ $ui_BorR = * ]
	echo "Invalid input recived"
	echo "Exiting now..."
	exit
fi
echo "End of script"
echo "exiting now..."
exit
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
#+	note when backing up and restoring: be sure to be in the same directory tree level on the restoring system.

# http://stackoverflow.com/questions/1605232/use-bash-to-read-a-file-and-then-execute-a-command-from-the-words-extracted
# take a list of words/comands from a file with each on a new line and run them with a command and or save to a new file for latter running.
#for WORD in `cat FILE`
#do
#   echo $WORD
#   command $WORD > $WORD
#done

# http://www.unix.com/shell-programming-scripting/75038-grep-inside-zip-file.html
# grep for patterns within a compressed file without having to un-compress it first.
# zgrep 'meter number' file*.zip

# directories and files to sort out
proc
		sys
		dev/pts
		$tarDir/Backup_Linux
		mnt
		acct
		bin
		cache
		config
		d
		data
		dev
		etc
		proc
		sbin
		sdcard
		storage
		sys
		system
		vendor
		boot.txt
		default.prop
		init
		init.cm.rc
		init.goldfish.rc
		init.rc
		init.superuser.rc
		init.trace
