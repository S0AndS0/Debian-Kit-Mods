#!/bin/bash
PATH=/bin:/usr/bin:/usr/local/bin ; export PATH 
umask 022
# Files that the script creates will have 755 permission.
# Thanks to Ian D. Allen, for this tip.
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
# variables auto
# find the name of this script and store it to a variable
osCN_fullScriptPath="$(readlink -f $0)"
# deleat last componit from ThisScript and store to another variable
osCN_ScriptDirectory="$(dirname $osCN_fullScriptPath)"
osComponent_filePath=$osCN_ScriptDirectory/Controller/Components




	echo "Create these databases using the following example"
	echo "___________"
	echo "	mysql -u root -p"
	echo ""
	echo "	#mysql>"
	echo ""
	echo "	#Keystone"
	echo "	CREATE DATABASE keystone;"
	echo "	GRANT ALL ON keystone.* TO 'keystoneUser'@'%' IDENTIFIED BY 'keystonePass357';"
	echo ""
	echo "	#Glance"
	echo "	CREATE DATABASE glance;"
	echo "	GRANT ALL ON glance.* TO 'glanceUser'@'%' IDENTIFIED BY 'glancePass357';"
	echo ""
	echo "	#Neutron"
	echo "	CREATE DATABASE neutron;"
	echo "	GRANT ALL ON neutron.* TO 'neutronUser'@'%' IDENTIFIED BY 'neutronPass357';"
	echo ""
	echo "	#Nova"
	echo "	CREATE DATABASE nova;"
	echo "	GRANT ALL ON nova.* TO 'novaUser'@'%' IDENTIFIED BY 'novaPass357';"
	echo ""
	echo "	#Cinder"
	echo "	CREATE DATABASE cinder;"
	echo "	GRANT ALL ON cinder.* TO 'cinderUser'@'%' IDENTIFIED BY 'cinderPass357';"
	echo ""
	echo "	quit;"
	echo "___________"
	echo "Starting : mysql -u root -p : so you can modify as shown"
	mysql -u root -p
	

