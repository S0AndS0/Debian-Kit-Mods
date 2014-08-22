#!/bin/bash
PATH=/bin:/usr/bin:/usr/local/bin ; export PATH 
# find the name of this script and store it to a variable
_fullScriptPath="$(readlink -f $0)"
# delete last component from ThisScript and store to another variable
_ScriptDirectory="$(dirname $_fullScriptPath)"
_varSave_path="$_ScriptDirectory/BitBiz_Records"

mkdir -p $_varSave_path
cd $_varSave_path

url_toScrape_All="http://bitbiz.io/members/"
url_toScrape_likes="http://bitbiz.io/members/?type=likes"

# url_toScrape_UI="http://bitbiz.io/members/s0ands0.190/"
# url_toScrape_credits="http://bitbiz.io/credits/"
# url_toScrape_shares="http://bitbiz.io/members/?type=richest_credits&currency_id=3"

_lynxOptions="-anonymous -source"

# 	Grab everyones latest status update
Latest_userStatus=`lynx $_lynxOptions $url_toScrape_All | grep -iC 1 "<h3 class=\"username\"><a" | sed 's/=/ /g' | sed 's/>/ /g' | awk '/title/ {gsub("<"," "); print}'`
# 	Grab everyones liked posts
Likes_usersReceived=`lynx $_lynxOptions $url_toScrape_likes | grep -iC 1 "Likes Received" | sed 's/>/ /g' | sed 's/</ /g' | awk '/liked/ {gsub("",""); print}'`
# 	Grab everyones message count
Likes_usersMessage_total=`lynx $_lynxOptions $url_toScrape_likes | grep -iC 1 "Likes Received" | sed 's/>/ /g' | sed 's/</ /g' | awk '/messages/ {gsub("",""); print}'`


######
# display what the variables do
echo "________"
echo "\$Latest_userStatus will list all users latest status updates."
echo "________"
lynx $_lynxOptions $url_toScrape_All | grep -iC 1 "<h3 class=\"username\"><a" | sed 's/=/ /g' | sed 's/>/ /g' | awk '/title/ {gsub("<"," "); print}'

echo "________"
echo "\$Likes_usersReceived will list all users likes recieved for their posts."
echo "________"
echo $Likes_usersReceived

echo "________"
echo "\$Likes_usersMessage_total will list all users total post count."
echo "________"
echo $Likes_usersMessage_total

######

outputStatus_byUser () { 
	for userName in $Latest_userStatus
		do
		echo $userName
		done
}
outputStatus_byUser

