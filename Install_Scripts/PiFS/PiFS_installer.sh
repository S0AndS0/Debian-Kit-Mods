#!/bin/bash
PATH=/bin:/usr/bin:/usr/local/bin ; export PATH 
echo "Please consider donating to the maintainer of this github by following the following link"
echo "https://github.com/S0AndS0/Debian-Kit-Mods/blob/master/DonationLinks.txt"
echo "___setting_variables"
# Variables
#  : ${USER?}
 : ${HOME?}
varDATE="$(echo $(date))"
# find the name of this script and store it to a variable
_fullScriptPath="$(readlink -f $0)"
# delete last component from ThisScript and store to another variable
_ScriptDirectory="$(dirname $_fullScriptPath)"


# Install dependancies
apt-get install make automake gcc libtool autoconf2.13
apt-get install libfuse-dev

# clone pifs source files
git clone https://github.com/philipl/pifs

# change directories and install pifs with make commands
cd pifs
./autogen.sh
./configure 
make 
make install

echo exit

# example commands
# πfs -o mdd=<metadata directory> <mountpoint>
# where the metadata directory is where πfs should store its metadata (such as filenames or the locations of your files in π) and mountpoint is your usual filesystem mountpoint.

# Install FUSE from sourceforge with git commands
git clone git://git.code.sf.net/p/fuse/fuse
# change directories and install with make commands
cd fuse
./makeconf.sh
./configure 
make 
make install 
modprobe fuse

