#!bin/bash
PATH=/bin:/usr/bin:/usr/local/bin ; export PATH 
umask 022
echo "___setting_variables"
# Variables
 : ${USER?} ${HOME?} 
# find the name of this script and store it to a variable
_fullScriptPath="$(readlink -f $0)"
# deleat last componit from ThisScript and store to another variable
_ScriptDirectory="$(dirname $cpuM_fullScriptPath)"

echo "___inporting_functions"
source $_ScriptDirectory/functionsFor_CryptoCurencies/prompts


echo "end of script. Exiting now..."
exit

# credits and sources

# Big thanks to the following links for making this script posible
	for merged mining of bitcoin and namecoin
http://www.devtome.com/doku.php?id=how_to_setup_a_merged_mining_bitcoin_pool_with_poolserverj



