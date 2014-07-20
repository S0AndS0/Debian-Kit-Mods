#########################################################
# notes and usage
# for <a> in <commandOR_file>; do <commandTo_performWith> $a; done 			# commands are used throuth this script
# more examples can be found from the following link for : for <a> in <command> do <stuff_to_or_with_$a> done 
# http://www.cyberciti.biz/faq/bash-for-loop/
# the simicoluns are used as breaks when these loops are on one line, such as when used in variabes
#+ using these loops in functions allow for removing the simicolun from the mix and allows for expanding on what is realling going on for the more complex stuff
#* usining these loops can include if then fi commands within for truelly adaptive scripting when used with default enviroment variables
#** such as $1 $2 $3 however when using these variables in your own scripts or mods of this one be sure not to overwrite the ones allready being used
#**+ but these are usually greater than $20 so unless you making really complex scripts it should be safe to play with

# $url_toScrape_All					# is the wallet to be watched and can be changed in the following directory
# + ~/Var_WalletWatcher 			# https://blockchain.info/address/<yourBitcoinAddress>
# ++ Curently set to 12C4Ua3zZHJWMyuZ4MTUZaZm3KPNFgo69A for the following bounty link
# http://bitbiz.io/threads/looking-for-someone-to-automate-the-our-money-flow-box-content-100-shares-reward.10/

# $referallAddress_printer 			# will return list of all referall addresses in the following format on new lines
#	/tx/<addressID>
# sample command bellow
# lynx -anonymous -source https://blockchain.info/address/12C4Ua3zZHJWMyuZ4MTUZaZm3KPNFgo69A?filter=2# | grep -iC 1 "hash-link" | awk '/href/ {gsub(" "," "); print $12 }' | sed 's/"/ /g' | awk '/href/ {gseb("",""); print $2}'

# donationAddress_Explorer 			# will return a list of addresses that have donated and the ammount after fees that you recived from each
# note if you comment out the line setting the $1 variable and call with the following example command the above will still work with very little modification on other sites
# 	donationAddress_Explorer https://blockchain.info <dir_toSave_to>
# for other sites you'll nead to modify quite a bit but this script should give you the basic templet to mod from.
#+ note2 if your feeling adventuras you can comment out both $1 and $2 variable assigners and set elswhere with the following example command
# 	donationAddress_Explorer https://blockchain.info $HOME/BitBiz_Records
#++ note3 this $2 does not check or correct for spaces in file paths which is why it has a default already set
# example of one full command bellow
# lynx -anonymous -source https://blockchain.info/tx/4ccabf964de06e518ffcc4ea38a70ed33937ad0a33b19687f08f91678700ca70 | grep -iC 1 "Total Output" | sed 's/"/ /g' | awk '/data-time/ {gsub(">",""); print $6}'
# lynx browser pipes it's outpu to grep which looks for lines with Total Output in lines from lynx
#+ the Total Output is what your wallet recived !after fees! this is so these totals may easely be budgeted or added or devided acuritly
# grep the pipes these lines to sed command that globaly repaces all dubble quots with spaces
# sed then pipes thes lines to awk which first looks for lines with data-time then subsitutes greaterthan signs with nothing and prints the sixth collum of that line
## a little messy but it works and can latter be sorted and merged with sort commands

# addDate_toDonationFile 			# this function saves the following three arguments sorted by date on thier own lines to a file
# 	<date> <time> <referal_addressTail>
# call this function with $1 set to a directory as shown bellow by commenting out the line that sets it fir use in other scripts
#	addDate_todonationFile </path/to_dir>
# though modification of internall commands may nead to be changed as the $1 variable goes through no checks for blank spaces in directory paths

# mergSort_donationFiles 			# this takes two files and murges and sorts them first by date then by ammount donated by each and saves to new file
# the $1 $2 and $3 variable assigners can be commented out for running with other scripts
#	mergSort_donationFiles <firstFile_toSort> <secondFile_toSort> <outputSorted_fileSaved>
# but should you do this for mods and other scripts that these variables should include the file names and be without spaces within arguments.
# the sort options used within explained
# -u 								# looks for uniqueness, this is how repeated arguments being sorted are ingnored
# -m 								# merges information onto single lines
# -k<collum> 						# sorts by specifide collom
# -k <collumStart>,<collumEnd>n 	# sorts by the start then end of collum collum specifide and the "n" at the end specifies that these are numbers to be sorted
# -o <file/path/fileName> 			# outputs the sorted results to the file speccifide

# $sortNumbers 				# is the sort command with -n option which sorts a list of numbers. Example bellow.
# + ~/Var_WalletWatcher 	# un-ordered input < 25 9 13 0.47 0.42 1 > oredered output < 0.42 0.47 1 9 13 25 >
# ++ Note the -b option is to ignore blank spaces if any at the start of new lines. See following link for more sort info
# http://www.skorks.com/2010/05/sort-files-like-a-master-with-the-linux-sort-command-bash/
# + the -t option in sort allows for non-space charictars to be used in conjuction with -k option for telling sort which collom to sort by
# ++ see example of sorting with sort -t: -k4 -n for sorting lists sepperated by collons and sorting by the 4th collom within.
# by using sort -t. -k 2,2n -k 4,4n a list on IPs can first be sorted by the

# $Web_lynxScrap_command 			# is a very adaptable variable 
# + ~/Var_WalletWatcher 			#+ but has been remade/named but the bellow examples are still usfull for explaining those variables and functions
# lynx -anonymous -source https://blockchain.info/address/12C4Ua3zZHJWMyuZ4MTUZaZm3KPNFgo69A?filter=2# | grep -iC 1 "hash-link"
# href="</tx/refeal_addres>" 		# https://blockchain.info<href_value>
#+ which apears in the 12 collom of each line of output and hash-link appears in the 11 collom of each line
# href="<refeal_addres>">year-month-day 24hours:hours:seconds</span>
#+ apear where colloms 14 and 15 meet see bellow
# lynx -anonymous -source https://blockchain.info/tx/4ccabf964de06e518ffcc4ea38a70ed33937ad0a33b19687f08f91678700ca70 | grep -iC 1 "Total Output"
# date-time="some_numbers">0.005... BTC</span>
