

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


