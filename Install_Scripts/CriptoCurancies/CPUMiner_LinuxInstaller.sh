#!/bin/bash
PATH=/bin:/usr/bin:/usr/local/bin ; export PATH 
echo "Please consider donating to the maintainer of this github by following the following link"
echo "https://github.com/S0AndS0/Debian-Kit-Mods/blob/master/DonationLinks.txt"
echo "___setting_variables"
# Variables
 : ${USER?} ${HOME?}
# find the name of this script and store it to a variable
_fullScriptPath="$(readlink -f $0)"
# delete last component from ThisScript and store to another variable
_ScriptDirectory="$(dirname $_fullScriptPath)"
echo "___inporting_shaired_functions"
. $_ScriptDirectory/ShairedFunctions/installDependancies
# list of variables from installDependancies

# list of functions from installDependancies
# dependsChooser 				# is set by internal variable $ui_gitSource from setDownloadSource function to properly prompt what packages are to be installed and install them
# CPUMine_depenancies 			# installs all package dependancies for bace minerd program
# dependsInstall_darkcoin 		# installs additinal package dependancies for darkcoin minerd fork
# dependsInstall_vertcoin 		# installs additinal package dependancies for darkcoin minerd fork that has spicific CPU compatibilaty
# dependsInstall_xcoin 			# installs additinal package dependancies for X11 based coins minerd fork

. $_ScriptDirectory/ShairedFunctions/makeConfig
# list of variables set by makeConfig
# $ui_cflag 					# aids in setting proper cflag settings for use with $ui_configure variable

# list of functions from makeConfig
# setMake_Config 				# sets cflags to variable for compiling minerd forks with make commands
# sourcePermmision_fixer 		# fixes the permissions of source files so they can be run with exicutable permissions

. $_ScriptDirectory/ShairedFunctions/userPrompts
# list of variables set by userPrompts
# 	$minerdOptions 				# variable that includes bellow indented variables in the corect order with option indicators for minerd run command
#		$ui_mineAddress 			# should be input without port such as "stratum+tcp://multi.ghash.io"
# 		$ui_mineAddress_username 	# for cex.io workers look like "S0AndS0.worker1" but other pools have thier own naming coventions
# 		$ui_mineAddress_port 		# for cex.io the port is usually "3333" but every pool's port settings are different
# 		$ui_mineAddress_password 	# for cex.io the password can be anything but other pools are set a bit stricter
# 	$ui_Download_Directory 		# sets directory to download source files to a variable
# 	$gitSource 						# sets web address for minerd forks to a variable
# 		$sourceDirectory 			# sets directory name of source to be downloaded to a variable for cd commands
# $ui_aptgetSudo 				# sets apt-get commands up with sudo for non-root users for installing dependancies
# $ui_teeFile 					# sets tee commands up with sudo for non-root users for writing to protected storage
# $ui_make 						# sets make commands up with sudo for non-root users
# $ui_chmod 					# sets chmod commands up with sudo for non-root users for fixing permissions of downloaded or writen files
# $ui_chown 					# sets chown commands up with sudo for non-root users for fixing ownership of writen files
# $ui_rm 						# sets rm commands up with sudo for non-root users for removing files from protected storage
# $ui_autogen 					# sets ./autogen.sh commands up with sudo for non-root users for minerd installation from source
# $ui_configure 				# sets ./configure commands up with sudo for non-root users which is further modifide with $ui_cflag variable

# list of functions from userPrompts
# promptTo_continue 			# Exits on anything but "yes" or "y" responce from user
# setUserAcount_settings 		# sets variables used to start "minerd" program
# setDownload_Directory 		# sets variabels used to make/change directories and file paths
# setDownloadSource 			# sets variabels used to assign which soucre to download
# ui_rootNOroot 				# sets many variables used for sudo/non-sudo commands
# prompt_wheezyUpgrade 			# prompts whether or not to mess with source lists and the installs dependancies set by dependsChooser

. $_ScriptDirectory/ShairedFunctions/tempWheezy_upgrade
# list of functions from tempWheezy_upgrade
# addWheezy_toSources 			# adds wheezy sources to a temp file if prompt_wheezyUpgrade gets a "yes" or "y" responce from user
# removeWheezy_fromSources 		# removes wheezy sources to a temp file if prompt_wheezyUpgrade gets a "yes" or "y" responce from user
# tempSource_permissionFixer 	# fixes permissions of wheezy sources to a temp file if prompt_wheezyUpgrade gets a "yes" or "y" responce from user
# keyFixer 						# adds any missing keys of wheezy sources to a temp file if prompt_wheezyUpgrade gets a "yes" or "y" responce from user

. $_ScriptDirectory/ShairedFunctions/printDialogs
# list of functions from printDialogs
# list_aptPackages_cpuminer 	# lists the packages that will be installed for every minerd fork
# list_aptPackages_darkcoin 	# lists known package dependancies for darkcoin minerd fork
# list_aptPackages_xcoin 		# list known package dependancies for X11 based coins minerd fork

. $_ScriptDirectory/ShairedFunctions/tmuxControl
# list of functions from tmuxControl
# dependsInstall_thisScript 	# installs tmux for easy control of miner jobs without human intervention
# start_tmux_MinerSession 		# starts minerd in new tmux session if it doesn't exsist already

# list of variables set by tmuxControl
# $tmuxSession_ID
# $tmuxWindow_ID

# Warn of paral to hardware
echo "This script and what it installs to your system may and likely will either damage or distroy your hardware"
echo "	by using this script and installed software you agree to the terms of thier relotive licencing and terms of use"
echo "	and agree that you are resposible for your own choices and consoquiences from those choices"
echo "running functions from : $_ScriptDirectory/ShairedFunctions/ ..."
promptTo_continue
ui_rootNOroot
setDownload_Directory
setDownloadSource
setMake_Config
setUserAcount_settings

echo "Settings for installation set, moving on to installing everything and starting your miner..."

promptTo_continue

prompt_wheezyUpgrade

cd $ui_Download_Directory
git clone $gitSource
sourcePermmision_fixer
cd $sourceDirectory
$ui_autogen
$ui_configure CFLAGS="$ui_cflag"
$ui_make

./minerd $minerdOptions

exit
# end of script


