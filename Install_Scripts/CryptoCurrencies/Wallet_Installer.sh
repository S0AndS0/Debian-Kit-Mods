#!/bin/bash
PATH=/bin:/usr/bin:/usr/local/bin ; export PATH 
echo "Please consider donating to the maintainer of this github by following the following link"
echo "https://github.com/S0AndS0/Debian-Kit-Mods/blob/master/DonationLinks.txt"
echo "___setting_variables"
# Variables
 : ${USER?} ${HOME?}
varDATE="$(echo $(date))"
# find the name of this script and store it to a variable
_fullScriptPath="$(readlink -f $0)"
# delete last component from ThisScript and store to another variable
_ScriptDirectory="$(dirname $_fullScriptPath)"
echo "___inporting_shaired_functions"

. $_ScriptDirectory/ShairedFunctions/userPrompts
# list of variables set by userPrompts
# 	$minerdOptions 				# variable that includes bellow indented variables in the corect order with option indicators for minerd run command
#		$ui_mineAddress 			# should be input without port such as "stratum+tcp://multi.ghash.io"
# 		$ui_mineAddress_username 	# for cex.io workers look like "S0AndS0.worker1" but other pools have thier own naming coventions
# 		$ui_mineAddress_port 		# for cex.io the port is usually "3333" but every pool's port settings are different and some network configurations will require opening or forwarding ports
# 		$ui_mineAddress_password 	# for cex.io the password can be anything but other pools are set a bit stricter
# 	$ui_Download_Directory 		# sets directory to download source files to a variable
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
# $ui_pip

# list of functions from userPrompts
# promptTo_continue 			# Exits on anything but "yes" or "y" responce from user
# setUserAcount_settings 		# sets variables used to start "minerd" program
# setDownload_Directory 		# sets variabels used to make/change directories and file paths

# ui_rootNOroot 				# sets many variables used for sudo/non-sudo commands
# prompt_wheezyUpgrade 			# prompts whether or not to mess with source lists and the installs dependancies set by dependsChooser
# prompt_tempMonitor 			# prompts for whether or not to run commands with temp monitering 

. $_ScriptDirectory/WalletFunctions/aptget_dependancies

# list of functions from aptget_dependancies
# install_Armory_github_aptget 		# installs Armory wallet from apt-get and github
# install_electrum_github_aptget 	# installs electrum wallet from apt-get and github

. $_ScriptDirectory/WalletFunctions/sourceChoices
# list of variables from sourceChoices
# $ui_walletSource 					# used internally for setting which source to install in an if then statement

# list of functions from sourceChoices
# choose_walletInstall_method 		# sets which wallet to install and from where

# script start
echo "This script currently make use of an internet connection but after installation has compleated it is advised to perminatly disconect your cold storage wallet from any network."
promptTo_continue
setDownload_Directory
ui_rootNOroot
choose_walletInstall_method

# script end
echo "Exiting now"
echo exit


