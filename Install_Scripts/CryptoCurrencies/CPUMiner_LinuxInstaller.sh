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

# _~_~_~_~_~_~_~_~_~_~_~_ #
# Some notes on how this is notated in the commented sections under each command to inport the functions contained in those files
# the -> . file/path/fileName <- is the command that I chose to use to inport contents of one file into the script because it works on; 
# 	chroot/shroot Linux ARM, Ubuntu 32 bit 12.04, and likely others such as Android's terminal
# elsewhere you can find the same command writen as \/
# 	source file/path/fileName <- but I found that to be unreliable.
# 
# Under each inport command I list first the funstions then the veriables if any are used externaly in a seperat list
# each list is orginized in two colloms; the first shows how to call the variable or function within the script
# 	and the second collom lists what that function or variable is suposed to do or contain or how it is used elsewhere.
# _~_~_~_~_~_~_~_~_~_~_~_ #

. $_ScriptDirectory/ShairedFunctions/installDependancies
# list of variables from installDependancies

# list of functions from installDependancies
# CPUMine_depenancies 			# installs all package dependancies for bace minerd program
# dependsInstall_darkcoin 		# installs additinal package dependancies for darkcoin minerd fork
# dependsInstall_vertcoin 		# installs additinal package dependancies for darkcoin minerd fork that has spicific CPU compatibilaty
# dependsInstall_xcoin 			# installs additinal package dependancies for X11 based coins minerd fork

. $_ScriptDirectory/ShairedFunctions/makeConfig
# list of variables set by makeConfig
# $ui_cflag 					# aids in setting proper cflag settings for use with $ui_configure variable
# algoChooser 					# sets algorithum to use in minerd commands based on what source was chosen

# list of variables set by makeConfig
# $ui_mineAlgo 					# contains the value to use as the "-a <algo>" option in minerd commands

# list of functions from makeConfig
# setMake_Config 				# sets cflags to variable for compiling minerd forks with make commands
# sourcePermmision_fixer 		# fixes the permissions of source files so they can be run with exicutable permissions

. $_ScriptDirectory/ShairedFunctions/userPrompts
# list of variables set by userPrompts
# 	$minerdOptions 				# variable that includes bellow indented variables in the corect order with option indicators for minerd run command
#		$ui_mineAddress 			# should be input without port such as "stratum+tcp://multi.ghash.io"
# 		$ui_mineAddress_username 	# for cex.io workers look like "S0AndS0.worker1" but other pools have thier own naming coventions
# 		$ui_mineAddress_port 		# for cex.io the port is usually "3333" but every pool's port settings are different and some network configurations will require opening or forwarding ports
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
# $ui_sensors 					# sets sensors command to sudo or no sudo prefix based on user prompt
# $ui_git 						# sets git command up with sudo for non-root users

# list of functions from userPrompts
# promptTo_continue 			# Exits on anything but "yes" or "y" responce from user
# setUserAcount_settings 		# sets variables used to start "minerd" program
# setDownload_Directory 		# sets variabels used to make/change directories and file paths

# ui_rootNOroot 				# sets many variables used for sudo/non-sudo commands
# prompt_wheezyUpgrade 			# prompts whether or not to mess with source lists and the installs dependancies set by dependsChooser
# prompt_tempMonitor 			# prompts for whether or not to run commands with temp monitering 

. $_ScriptDirectory/ShairedFunctions/tempWheezy_upgrade
# list of functions from tempWheezy_upgrade
# addWheezy_toSources 			# adds wheezy sources to a temp file if prompt_wheezyUpgrade gets a "yes" or "y" responce from user
# removeWheezy_fromSources 		# removes wheezy sources to a temp file if prompt_wheezyUpgrade gets a "yes" or "y" responce from user
# tempSource_permissionFixer 	# fixes permissions of wheezy sources to a temp file if prompt_wheezyUpgrade gets a "yes" or "y" responce from user
# keyFixer 						# adds any missing keys of wheezy sources to a temp file if prompt_wheezyUpgrade gets a "yes" or "y" responce from user

. $_ScriptDirectory/ShairedFunctions/printDialogs
# list of functions from printDialogs
# warningHW_damage 				# warns users that they are doing something dangerious and costly
# list_aptPackages_cpuminer 	# lists the packages that will be installed for every minerd fork
# list_aptPackages_darkcoin 	# lists known package dependancies for darkcoin minerd fork
# list_aptPackages_xcoin 		# list known package dependancies for X11 based coins minerd fork
# list_cpuFork_Compatiblitly 	# lists what CPU's the minerd forks will work on
# list_cpuMining_software 		# lists all curently available to install cpu mining software for easy install with this script

. $_ScriptDirectory/ShairedFunctions/tmuxControl
# list of functions from tmuxControl
# dependsInstall_thisScript 	# installs tmux for easy control of miner jobs without human intervention
# start_tmux_MinerSession 		# starts minerd in new tmux session if it doesn't exsist already named $tmuxSession_ID
# end_tmuxMinerSession 			# ends minerd sessions named $tmuxSession_ID
# reatach_tmuxMinerSession 		# reataches to tmux session if already started

# list of variables set by tmuxControl
# $tmuxSession_ID
# $tmuxWindow_ID
# $tmuxTester

. $_ScriptDirectory/ShairedFunctions/temp_monitor
# list of functions from temp_monitor
# Android_debianKit_temp
# Download_tempThrottle

# list of variables set by temp_monitor
# $fBatteryTemp 			# outputs tempreture of battery on Android devices running Debian Kit's form of Linux
# $fCPUtemp 				# outputs tempreture of CPU on PC's running Debian bassed Linux
# $ui_tempretureLevel_Kill 	# sets the max tempreture that the CPU or battery can get to before mining tasks are stoped

. $_ScriptDirectory/ShairedFunctions/sourceChoices
# list of functions from sourceChoises
# setDownloadSource 			# sets variabels used to assign which soucre to download
# dependsChoicer 				# is set by internal variable $ui_gitSource from setDownloadSource function to properly prompt what packages are to be installed and install them
# install_uiSource 				# installs users choice based on userPrompts and makeConfig options

echo "running functions from : $_ScriptDirectory/ShairedFunctions/ ..."
echo "_________"
list_cpuMining_software
list_cpuFork_Compatiblitly
warningHW_damage
echo "_________"
promptTo_continue
ui_rootNOroot
setDownload_Directory
setDownloadSource
setMake_Config
setUserAcount_settings

echo "_________"
echo "Settings for installation set, moving on to installing everything"
promptTo_continue
prompt_wheezyUpgrade
echo "_________"

install_uiSource

echo "starting your miner session in this window..."
./minerd $minerdOptions

exit
# end of script


