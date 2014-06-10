#!/bin/bash
PATH=/bin:/usr/bin:/usr/local/bin ; export PATH 

echo "___setting_variables"
# Variables
 : ${USER?} ${HOME?}
# find the name of this script and store it to a variable
_fullScriptPath="$(readlink -f $0)"
# delete last component from ThisScript and store to another variable
_ScriptDirectory="$(dirname $_fullScriptPath)"
# inport shaired functions
source $_ScriptDirectory/ShairedFunctions/installDependancies
source $_ScriptDirectory/ShairedFunctions/makeConfig
source $_ScriptDirectory/ShairedFunctions/userPrompts

