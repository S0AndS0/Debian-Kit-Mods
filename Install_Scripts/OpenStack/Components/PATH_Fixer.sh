#!/bin/bash
echo "This script is intended to fix the following error:"
echo "____________"
echo "	dpkg: warning: 'ldconfig' not found in PATH or not executable."
echo "	dpkg: warning: 'start-stop-daemon' not found in PATH or not executable."
echo "	dpkg: error: 2 expected programs not found in PATH or not executable."
echo "	Note: root's PATH should usually contain /usr/local/sbin, /usr/sbin and /sbin."
echo "	E: Sub-process /usr/bin/dpkg returned an error code (2)"
echo "	A package failed to install.  Trying to recover:"
echo "	dpkg: warning: 'ldconfig' not found in PATH or not executable."
echo "	dpkg: warning: 'start-stop-daemon' not found in PATH or not executable."
echo "	dpkg: error: 2 expected programs not found in PATH or not executable."
echo "	Note: root's PATH should usually contain /usr/local/sbin, /usr/sbin and /sbin."
echo "____________"
echo "Exposing what the \$PATH variable contains:"
echo "____________"
echo $PATH
echo "____________"
echo "exporting : usr/sbin : to the \$PATH variable:"
echo "____________"
export PATH=$PATH:/usr/local/sbin:/usr/sbin:/sbin
echo "____________"
echo "Exposing what the \$PATH variable contains again:"
echo "____________"
echo $PATH
echo "____________"
echo "Running : apt-get -f install : to fix any missing packages that may have resulted in above error:"
apt-get -f install
echo "____________"
echo "This script was made posible thanks to the following link:"
echo "	http://forums.debian.net/viewtopic.php?f=20&t=69093"
echo "End of script, exiting now..."
exit
