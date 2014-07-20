#!/bin/bash
PATH=/bin:/usr/bin:/usr/local/bin ; export PATH 
# find the name of this script and store it to a variable
_fullScriptPath="$(readlink -f $0)"
# delete last component from ThisScript and store to another variable
_ScriptDirectory="$(dirname $_fullScriptPath)"
_varSave_path="$_ScriptDirectory/BitBiz_Records"

mkdir -p $_varSave_path
cd $_varSave_path

url_toScrape_All="https://blockchain.info/address/12C4Ua3zZHJWMyuZ4MTUZaZm3KPNFgo69A"
url_toScrape_Recived="https://blockchain.info/address/12C4Ua3zZHJWMyuZ4MTUZaZm3KPNFgo69A?filter=2#"
_lynxOptions="-anonymous -source"

write_Date_fullAddress=`lynx $_lynxOptions $url_toScrape_Recived | grep -iC 1 "hash-link" | sed 's/"/ /g' | awk '// {gsub(">",""); print}' | awk '// {gsub("<",""); print $30,$25}' | awk '// {gsub("/tx/","https://blockchain.info/tx/"); print}' | sort -t- -n -k1,3 -r | tee -a DatesAddresses.txt`
referallAddress_printer=`lynx $_lynxOptions $url_toScrape_Recived | grep -iC 1 "hash-link" | awk '/href/ {gsub(" "," "); print $12 }' | sed 's/"/ /g' | awk '/href/ {gsub(">",""); print $2}'`

# functions

Write_sortedAddressesByDate_withDonationAmmount () { 
	# 1 AmmountsAddresses.txt
	# 2 dateSorted_Adresses.txt
	# 3 DonationsBy_Date.txt
	for addresses1 in $1
	do
		for addresses2 in $2
		do
			sort -k2 addresses1 addresses2 | tee -a $3
		done
	done
}

Write_sortedAddressesByDate () { 
	# 1 DatesAddresses.txt
	# 2 dateSorted_Adresses.txt
	for dates in $1
	do
		sort -t- -n -k1,3 -r $1 | tee -a $2
	done
} 

Write_DonationWithAddress () { 
	# 1 $referallAddress_printer
	# 2 AmmountsAddresses.txt
	for address in $1
	do
		_amount_address=`lynx $_lynxOptions https://blockchain.info$address | grep -iC 1 "Total Output" | sed 's/"/ /g' | sed 's/>//g' | awk '{print $6}' | sort -n -k1 -u`
		echo $_amount_address https://blockchain.info$address | tee -a $2
	done
}


# script start
$write_Date_fullAddress
Write_DonationWithAddress $referallAddress_printer AmmountsAddresses.txt
Write_sortedAddressesByDate DatesAddresses.txt dateSorted_Adresses.txt
Write_sortedAddressesByDate_withDonationAmmount AmmountsAddresses.txt dateSorted_Adresses.txt DonationsBy_Date.txt

cd ~

