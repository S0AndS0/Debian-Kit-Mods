#!/bin/bash
PATH=/bin:/usr/bin:/usr/local/bin ; export PATH 
umask 022 
# Files that the script creates will have 755 permission.
# Thanks to Ian D. Allen, for this tip.
# Variables start
debPruner_ls=`ls -a | grep -v '.etc.debian-android' | grep -v '.root.debian-android' | grep -v '.sbin.debian-android' | grep -v 'bin' | grep -v 'boot' | grep -v 'home' | grep -v 'lib' | grep -v 'media' | grep -v 'selinux' | grep -v 'srv' | grep -v 'tmp' | grep -v 'usr' | grep -v 'var'`
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
		echo "Writting a file to be sure we don't backup Android system files."
		echo '.
		..
		acct
		cache
		config
		d
		data
		default.prop
		dev
		etc
		init
		init.cm.rc
		init.goldfish.rc
		init.latte.rc
		init.rc
		init.superuser.rc
		init.trace.rc
		init.usb.rc
		init.victory.rc
		init.victory.usb.rc
		lpm.rc
		mnt
		proc
		root
		sbin
		sd-ext
		sdcard
		sys
		system
		ueventd.goldfish.rc
		ueventd.latte.rc
		ueventd.rc
		vendor' | tee -a $tarDir/exclude.txt
	elif [ $ui_chOrschRoot = d ]
	then
		$debPruner_ls >> cat $tarDir/exclude.txt
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
	echo "Running backup commands using above safeties"
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

