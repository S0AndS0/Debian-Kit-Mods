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


