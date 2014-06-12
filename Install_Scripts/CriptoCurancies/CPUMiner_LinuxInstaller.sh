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
# dependsChooser
# CPUMine_depenancies
# dependsInstall_darkcoin
# dependsInstall_vertcoin
# dependsInstall_xcoin

. $_ScriptDirectory/ShairedFunctions/makeConfig
# list of variables set by makeConfig
# $ui_cflag
# list of functions from makeConfig
# setMake_Config
# sourcePermmision_fixer

. $_ScriptDirectory/ShairedFunctions/userPrompts
# list of variables set by userPrompts
# 	$minerdOptions
#		$ui_mineAddress $ui_mineAddress_username $ui_mineAddress_port $ui_mineAddress_password
# 	$ui_Download_Directory
# 	$gitSource
# 		$sourceDirectory
# $ui_aptgetSudo
# $ui_teeFile
# $ui_make
# $ui_chmod
# $ui_chown
# $ui_rm
# $ui_autogen
# $ui_configure

# list of functions from userPrompts
# promptTo_continue
# setUserAcount_settings
# setDownload_Directory
# setDownloadSource
# ui_rootNOroot
# prompt_wheezyUpgrade

. $_ScriptDirectory/ShairedFunctions/tempWheezy_upgrade
# list of functions from tempWheezy_upgrade
# addWheezy_toSources
# removeWheezy_fromSources
# tempSource_permissionFixer
# keyFixer

. $_ScriptDirectory/ShairedFunctions/printDialogs
# list of functions from printDialogs
# list_aptPackages_cpuminer
# list_aptPackages_darkcoin
# list_aptPackages_xcoin

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

# tmux examples
# start tmux session named Miner1
tmux new -s Miner1

# atach to Miner1
tmux attach -t Miner1

# kill Miner1 session
tmux kill-session -t Miner1

# start a nes session named Miner1 in window named CPU_Mining
tmux new -s Miner1 -n CPU_Mining

# to detach from tmux session and leave it running
Ctrl+b d


