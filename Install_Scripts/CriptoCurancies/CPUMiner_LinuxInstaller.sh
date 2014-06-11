#!/bin/bash
PATH=/bin:/usr/bin:/usr/local/bin ; export PATH 

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
# dependsInstall_cpuminer

. $_ScriptDirectory/ShairedFunctions/makeConfig
# list of variables set by makeConfig
# $ui_cflag
# list of functions from makeConfig
# setMake_Config

. $_ScriptDirectory/ShairedFunctions/userPrompts
# list of variables set by userPrompts
# 	$minerdOptions
#		$ui_mineAddress $ui_mineAddress_username $ui_mineAddress_port $ui_mineAddress_password
# 	$ui_Download_Directory
# 	$gitSource
# 		$sourceDirectory
# $ui_aptgetSudo
# $ui_conf_
# $ui_teeFile
# $ui_make
# list of functions from userPrompts
# promptTo_continue setUserAcount_settings setDownload_Directory setDownloadSource ui_rootNOroot


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
echo "	...sit back and relax..."
$ui_aptgetSudo update

dependsInstall_cpuminer
cd $ui_Download_Directory
git clone $gitSource
cd $sourceDirectory
$ui_conf_autogen.sh
$ui_conf_configure CFLAGS="$ui_cflag"
$ui_make

./minerd $minerdOptions

