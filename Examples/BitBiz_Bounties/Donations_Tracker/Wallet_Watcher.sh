#!/bin/bash
PATH=/bin:/usr/bin:/usr/local/bin ; export PATH 
echo "___setting_variables"
# Variables
 : ${USER?} ${HOME?}
varDATE="$(echo $(date))"
# find the name of this script and store it to a variable
_fullScriptPath="$(readlink -f $0)"
# delete last component from ThisScript and store to another variable
_ScriptDirectory="$(dirname $_fullScriptPath)"
varSave_path="$_ScriptDirectory/BitBiz_Records/$varDATE/"

echo "___inporting_shaired_functions"
#. $_ScriptDirectory/Shaired_Functions/Fun_WalletWatcher
. $_ScriptDirectory/Var_WalletWatcher
echo "You have permission to modify, dristribute, and copy anypart of this script"
echo "so long as within your new versions or scripts you include links back to the authers bothe for the sections and entire script that was used."
echo "This is so others can easilly find more help on thier projects and so on..."
echo "Listing your wallet information"
echo "	-- Date -- Time -- refferal_address --"
echo $dateTimeAddress_lister
echo "	-- amount_after_fees -- full_refferal_address --"
echo $donationAmmount_andAddress_forEach
echo "~-~-~-~-~-~-~-~-~-~-~-~-~-~-~"
echo "Using some functions to clean that up and save to some files"
#donationAddress_Explorer
#addDate_toDonationFile
#mergSort_donationFiles
echo "~-~-~-~-~-~-~-~-~-~-~-~-~-~-~"
echo "End of script. Exiting now..."
exit

# list of usefull function commands

# donationAddress_Explorer $1 $2
# donationAddress_Explorer $url_toScrape_base $varSave_path
# 	Which whith the above variables assigned within the function looks like the following example
# donationAddress_Explorer https://blockchain.info $_ScriptDirectory/BitBiz_Records/$varDATE/Deposits_unsorted.txt
# 		The file saved will be un_ordered because latter merging and sorting commands are used to clean it up

# addDate_toDonationFile $1
# addDate_toDonationFile $varSave_path
# 	Which with the above variables assigned within the function look like the following example
# addDate_toDonationFile $_ScriptDirectory/BitBiz_Records/Deposits_dateSorted.txt

# mergSort_donationFiles $1 $2 $3
# mergSort_donationFiles $varSave_path/Deposits_dateSorted.txt $varSave_path/Deposits_unsorted.txt $varSave_path/donationsDateAmount_Compiled.txt
# 	Which with the above variables assigned within the function look like the following example
# mergSort_donationFiles $_ScriptDirectory/BitBiz_Records/Deposits_dateSorted $_ScriptDirectory/BitBiz_Records/Deposits_unsorted $_ScriptDirectory/BitBiz_Records/donationsDateAmount_Compiled.txt


