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
# $ui_aptReppo_add 				# adds ppa repos; used in pool installer scripts currently
# $ui_mkdir 					# sets how to make directories; either with or without sudo, set by ui_rootNOroot function

# list of functions from userPrompts
# promptTo_continue 			# Exits on anything but "yes" or "y" responce from user
# setUserAcount_settings 		# sets variables used to start "minerd" program
# setDownload_Directory 		# sets variabels used to make/change directories and file paths

# ui_rootNOroot 				# sets many variables used for sudo/non-sudo commands
# prompt_wheezyUpgrade 			# prompts whether or not to mess with source lists and the installs dependancies set by dependsChooser
# prompt_tempMonitor 			# prompts for whether or not to run commands with temp monitering 

. $_ScriptDirectory/MergedPool_functions/SourceChooser
# list of variables in SourceChooser
# $ui_sourcePool_choise 			# used internally with sourceChooser_promt and $poolChoice
# 	$poolChoice 					# used externally : to set which dependancies to install and source files to download
# 	$poolSource 					# used externally : sets link to be downloaded for pool server software
# 	$poolDir 						# used externally : sets directory of source for pool server software to a
# $ui_tmuxORscreen 					# used internally : sets whether or not to use screen or tmux to start commands
# 	$ui_poolServiceStart_header 	# used externally : sets which header or prefix to use for starting your pool service
# 	$ui_poolHost_user 				# 
# 	$ui_poolHost_password 			# 
# 	$$ui_poolHost_fee  				# 

# list of functions from SourceChooser
# prompt_sourceChooser 				# sets $poolChoice, $poolSource, $poolDir variables for use in other functions
# prompt_poolComands 				# 
# poolSession_hostStart 			# starts pool host services based on variables set by prompt_poolComands
# sourceChooser_dependsInstaller 	# installs all know dependancies for both pool and coins
# pool_sourceChooser_gitCloner 		# clones the sellected pool software
# pool_sourceChooser_gitInstaller 	# installs pool software
# sourceChooser_confConfigurer 		# 
# helpfullExamples_poolCommands 	# 

echo "Starting script run time..."
promptTo_continue
ui_rootNOroot
setDownload_Directory
cd $ui_Download_Directory
prompt_sourceChooser
prompt_poolComands
sourceChooser_dependsInstaller

pool_sourceChooser_gitCloner
pool_sourceChooser_gitInstaller


echo "End of script. Exiting now..."
echo exit

# credits and sources
# guide that was used for p2pool1 option
# http://www.bitcointrading.com/forum/mining-pools/a-complete-guide-to-p2pool-merged-mining-(btcnmcdvcixci0c)-plus-ltc-linux/


