======================
# 	notes on packages
# libcurl4-gnutls-dev and libcurl4-openssl-dev will remove one another if the other is to be installed

# https://github.com/slimcoin/slimminer

# 	updated scrypt and sha-256 cpuminer from tar (original cpuminer)
# 	+ compiles fine on ARM processors
# 	++ incirperated in script
# http://webcache.googleusercontent.com/search?q=cache:EiHbDpksWkAJ:https://bitcointalk.org/index.php%3Ftopic%3D55038.0+&cd=3&hl=en&ct=clnk&gl=us
# apt-get install build-essential libcurl4-openssl-dev gcc make
# wget http://sourceforge.net/projects/cpuminer/files/pooler-cpuminer-2.4.tar.gz
# tar xzf pooler-cpuminer-2.4.tar.gz
# cd cpuminer-2.4
# ./configure CFLAGS="-O3"
# make

# 	darkcoin cpuminer from github
# 	+ errors on ARM processors :-: emmintrin.h "fatal error : emmintrin.h : No such file or directory."
# 	++ incirperated in script
# http://altcoins.com/vps-mining-guide-for-cpu-altcoins.html
# apt-get install automake autoconf build-essential bc curl dos2unix fail2ban havegedsudo
# apt-get install libboost-all-dev libcurl4-openssl-dev libdb++-dev libleveldb-dev libminiupnpc-dev libssl-dev m4 nano unzip vim
# git clone https://github.com/ig0tik3d/xcoin-cpuminer
# cd xcoin-cpuminer
# ./autogen.sh
# ./configure CFLAGS="-O2"
# make
# example command :-: ./minerd -a X11 -o pool_addres:pool_port -u your_user.worker -p x

# 	qubitcoin cpuminer from github
# 	+ errors on ARM processors :-: emmintrin.h "fatal error : emmintrin.h : No such file or directory."
# https://bitcointa.lk/threads/ann-q2c-qubitcoin-new-secure-hashing-cpu-gpu-new-update-0-8-4-1.234478/page-98
# apt-get install libcurl4-openssl-dev libncurses5-dev pkg-config automake yasm make
# git clone https://github.com/ig0tik3d/QubitCoin-cpuminer-v.1.1
# cd ./QubitCoin-cpuminer-v.1.1
# ./autogen.sh
# ./configure CFLAGS="-O3"
# make
# example command :-: ./minerd -a qubit -o stratum+tcp://q2c.cpu-pool.net:3470 -u YourLogin.worker -p password

# 	quarkcoin cpuminer from github
# 	+ errors on ARM processors :-: emmintrin.h "fatal error : emmintrin.h : No such file or directory."
# http://forum.qrk.cc/thread/594/ubuntu-debian-miner-install-guide
# apt-get install autoconf autogen automake build-essential libcurl4-openssl-dev
# git clone https://github.com/uncle-bob/quarkcoin-cpuminer.git
# cd quarkcoin-cpuminer
# wget raw.github.com/rallat/quarkcoin-cpuminer/4e6c263c837bd04261df1ba7383ea828409ff498/acinclude.m4
# ./autogen.sh
# ./configure CFLAGS="-O3"
# make
# example command :-: ./minerd -a quark -o stratum+tcp://lowend.fm:8372 -t 8 -u <wallet address>

# 	quarkcoin cpuminer from github (alternets)
# 	+ first alternet workes on ARM prossesors for compiling when using :-: ./configure CFLAGS="-O3 -mfpu=neon"
#	++ both options incorperated now
# http://forum.qrk.cc/thread/173/mine-linux-mining-step-quark
# apt-get install build-essential libcurl4-openssl-dev libjansson4 libjansson4*dev
# git clone https://github.com/Neisklar/quarkcoin-cpuminer.git
# cd quarkcoin-cpuminer
# ./autogen.sh
# ./configure CFLAGS="-O3"
# make
# 	...or...
# wget http://stonefoz.myfastmail.com/cpuminer-quark2.zip
# unzip cpuminer-quark2.zip
# cd cpuminer-quark2
# ./autogen.sh
# ./configure CFLAGS="-msse2 -O3"
# make
# example command :-: ?

# 	vertcoin cpuminer from tar
# 	+ workes on ARM prossesors for compiling when using :-: ./configure CFLAGS="-O3 -mfpu=neon"
# https://gist.github.com/Toorop/9727120
# apt-get install unzip build-essential curl automake libcurl4-gnutls-dev
# mkdir -p ~/vertcoin
# cd ~/vertcoin
# wget https://github.com/Bufius/cpuminer-vert/archive/master.zip
# unzip master.zip
# cd cpuminer-vert-master/
# ./autogen.sh
# ./configure CFLAGS="-O3"
# make
# example command :-: ?

# 	vertcoin cpu miner from github
# http://vertcoinforum.com/index.php?topic=56.0
# apt-get install make gcc m4 automake libevent-dev zlibc zlib1g-dev libjansson-dev libcurl4-openssl-dev
# git clone https://github.com/Bufius/cpuminer-vert
# cd cpuminer-vert
# ./autogen.sh
# ./configure CFLAGS="-O3"
# make
# example command :-: ./minerd -a scrypt -o stratum+tcp://server:port -u "username.worker" -p "password"

# 	skeincoin cpu miner from github
# apt-get install ?
# git clone https://github.com/skeincoin/skeincoin-cpuminer
# cd skeincoin-cpuminer
# ./autogen.sh
# ./configure CFLAGS="?"
# make
# example command :-: ?

# 	myriadcoin cpu miner from github
# apt-get install ?
# git clone https://github.com/myriadcoin/groestlcoin-cpuminer
# or :-: https://github.com/ig0tik3d/myriadcoin-groestl-cpuminer-v1.0b
# cd groestlcoin-cpuminer
# ./autogen.sh
# ./configure CFLAGS="?"
# make
# example command :-: ?

#	heavycoin
# apt-get install automake build-essential libcurl4-openssl-dev git zip
# git clone https://github.com/heavycoin/cpuminer-heavycoin
# sed -i 's/@LIBCURL@ @JANSSON_LIBS@ @PTHREAD_LIBS@ @WS2_LIBS@ -lssl/@LIBCURL@ @JANSSON_LIBS@ @PTHREAD_LIBS@ @WS2_LIBS@ -lssl -lcrypto/' Makefile.am
# cd cpuminer-heavycoin
# ./autogen.sh
# ./configure CFLAGS="?"
# make
# example command :-: ./minerd -a heavy -v 32 -o stratum+tcp://stratum01.mycryptopool.info:3333 -u worker.user -p workerPass
#										-v XX = your vote

# 	groestlcoin
# apt-get install libcurl4-gnutls-dev autoconf automake libtool yasm m4 make g++ build-essential dos2unix libminiupnpc-dev libdb++-dev libgmp-dev libssl-dev libboost-all-dev
# git clone https://github.com/ig0tik3d/GroestlCoin-cpu-1.0a
# or : https://github.com/vitorallo/GroestlCoin-cpu-1.0a
# cd GroestlCoin-cpu-1.0a
# ./autogen.sh
# ./configure CFLAGS="-O3 -msse4"
# make
# example command :-: ./minerd -a groestl -o stratum+tcp://erebor.dwarfpool.com:3345 -u <walletAddress> -p workerPass -t <threads>

# bitblockcoin
# apt-get install ?
# git clone https://github.com/bitblockproject/Bitblock-CPUminer
# cd Bitblock-CPUminer
# ./autogen.sh
# ./configure CFLAGS="-O3"
# make
# example command :-: ?

======================
apt-get install libghc-byteorder-dev libghc-cpu-dev
======================

sources of info and credits
A to the point and working guide to setting up cpuminer on any device!
	http://linuxclues.blogspot.com/2013/08/cpuminer-build-source-debian-litecoin.html

for mining cripto curanies on android or raspberry pi with or without usb mining hardware
	http://petesblog.net/blog/bitcoin-mining-on-raspberry-pi
for Stratum mining proxy
	https://github.com/slush0/stratum-mining-proxy
for tabbles and more tables comparing everything
	https://en.bitcoin.it/wiki/Mining_hardware_comparison
	
for compiling cpuminer from source


	https://litecoin.info/Mining_hardware_comparison
# cflag options for ARM
most use the following ~
on ~ 						Soft Float
	CFLAGS="-O3"
on ~						Debian 7 armhf, Samsung Galaxy S II, 
	CFLAGS="-O3 -mfpu=neon"
ARM Cortex-A9 (L2=1MiB) 	Linaro Ubuntu LIB-12.09.6A, Freescale i.MX6 Quad, Sabre-Lite Board
	CFLAGS="-O2"
ARM Cortex-A15 				ChrUbuntu 12.04, Samsung Chromebook XE303C12
	CFLAGS="-O3 -mfpu=neon-vfpv4"
	
	https://wiki.debian.org/ArmHardFloatPort/VfpComparison
there maybe options for
	VFPv1 - obsoleted by ARM
	VFPv2 - optional on ARMv5 and ARMv6 cores
		~ Supports standard FPU arithmetic (add, sub, neg, mul, div), full square root
		~ 16 64-bit FPU registers
	VFPv3[-D32]
		Broadly compatible with VFPv2 but adds
			~ Exception-less FPU usage
			~ 32 64-bit FPU registers as standard
			~ Adds VCVT instructions to convert between scalar, float and double.
			~ Adds immediate mode to VMOV such that constants can be loaded into FPU registers
	VFPv3-D16
		~ As above, but only has 16 64-bit FPU registers in VFPv3-D16 variant
	VFPv3-F16 variant
		~ Uncommon but supports IEEE754-2008 half-precision (16-bit) floating point
	VFPv4
		~ Cortex-A5
		~ Has a "fused multiply-accumulate"


arcived link to config options that may be usefull
	http://webcache.googleusercontent.com/search?q=cache:iaTfeAd3LssJ:https://bitcointalk.org/index.php%3Ftopic%3D55038.640+&cd=3&hl=en&ct=clnk&gl=us
[QUOTE=https://bitcointalk.org/index.php?action=profile;u=125532]
experiment with cpuminer 2.3.2 at different ARM computers and these are hashrates I measured:

=============================================
Toshiba AC100 subnotebook running Lubuntu 12.10, Nvidia Tegra2 chip, 2x 1000 MHz
ARMv7 Processor rev 0 (v7l)

./configure CFLAGS="-O3 -pipe" && make
# LTC hashrate: 1.38 khash/s (2x 0.69)
# BTC hashrate: 820 khash/s (2x 410)

=============================================
HDMI stick MK802 II running debian 7.0 armhf, 1x 1000 MHz
ARMv7 Processor rev 2 (v7l) with NEON support (Allwinner A10)

./configure CFLAGS="-O3 -pipe" && make
# LTC hashrate: 0.73 khash/s
# BTC hashrate: 566 khash/s

./configure CFLAGS="-O3 -pipe -mfpu=neon" && make
# LTC hashrate: 0.86 khash/s
# BTC hashrate: 600 khash/s

=============================================
BeagleBone Black running debian 7.0 armhf, 1x 1000 MHz
ARMv7 Processor rev 0 (v7l) with NEON support, CPU is "double issue" (it can execute two instructions in parallel)

./configure CFLAGS="-O3 -pipe" && make
# LTC hashrate: 0.71 khash/s
# BTC hashrate: 555 khash/s

./configure CFLAGS="-O3 -pipe -mfpu=neon" && make
# LTC hashrate: 0.84 khash/s
# BTC hashrate: 589 khash/s

=============================================
Raspberry PI running debian 7.0 armhf, 1x 900 MHz (CPU overclocked from 700 to 900 MHz)
ARMv6-compatible processor rev 7 (v6l)

./configure CFLAGS="-O3 -pipe" && make
# LTC hashrate: 0.43 khash/s
# BTC hashrate: 258 khash/s
[/QUOTE]
Notes
	More than likely unless you are willing to invest the few hundred dollars for the hardware this will not be very usefull.
	However if combined with a MPI option you maybe able to leverage multiple devices to work together.
	Curently this is outside the scope of this script pack, however, I am working on this so new users have the opertunanty to mine bitcoins.
	I'll be working on alternet cripto coins shortly so be sure to check back often.


