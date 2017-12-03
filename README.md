# RPI-Wifi-DRVr
This script allows an easy way to Install and Compile non-Raspbian-Included Wi-fi Drivers on any Raspberry PI (RPI), It's Mostly a Kernel header installer script which allows the user to compile kernel Modules, made specially for wifi drivers to install in a fast manner without having to compile the Raspbian Kernel Source after every firmware release/kernel update (rpi-update). 3 easy steps !
<br>
This Kernel Headers are pre-compiled and are 3rd-party distributed, this installs it and gets you ready to build any kernel module, particularly wifi drivers, but it can be used for any kernel module or driver build with (make) in raspbian (all versions).

<br>
<h1>Why?</h1>
So, you have a nifty Raspberry Pi 3 Model B and or the Raspberry Pi Zero W , and you feel like -- man it comes with wifi and it's 802.11n, Yes and yes but don't fool yourself it uses the Broadcom BCM43438 chip, this chip is an 802.11(n)-- but it does not provide 300 Mbps Wireless-N broadband speeds, it's limited to ( single channel mode ) of only 20 MHZ which is 130-150 Mbps rated range, and not the well loved ( 802.11n channel bonding mode ) which operates at 40 MHz on 300 Mbps rated range.
<br>
<br>
Damm! is right!...
My fix was to get any off-the-shelf USB Wifi dongle which is Linux Compatible and Install the linux driver in the Raspbian ARM emviroment with the foundation of this script.
not only did I find a 300 Mbps USB wifi dongle that was never claimed compatible with the Raspberry Pi as some brands do, yet I made it work, but there is more I made a 802.11AC 5 GHZ USB 3.0 (backwards compatible USB 2.0) dongle work in 3 easy steps by running this script. Enjoy !
<br>
<h1> Install:</h1>
<br>
Proper Installion of the script.
<br>
git clone https://github.com/dernyn/RPI-Wifi-DRVr
<br>
 $  sudo mv ./RPI-Wifi-DRVr/rpi-kmod.sh /usr/bin/rpi-kmod
<br>
 $  sudo chmod +x /usr/bin/rpi-kmod
<br>
 rpi-kmod
<br>
<br>
This will run from outside the git clone directory.
<br>
<br>
<h1> Run:</h1>
<br>
--if you installed it,
<br>
Just type;    rpi-kmod 
<br>
if you don't want it installed just get the script from the RPI shell and run it, with :
<td>
<br>
<br>
git clone https://github.com/dernyn/RPI-Wifi-DRVr
<br>
sh ./RPI-Wifi-DRVr/rpi-kmod.sh
<br>
or
<br>
cd RPI-Wifi-DRVr
<br>
sh rpi-kmod.sh
<br>
<h1>Find your Wifi(or other device) Chipset/Manufacture's Linux driver</h1>
<br>
try to check compatibility and kernel version requirements.
<br>
but mainly go to the path of your extracted .tar/.zip/.rar----etc. downloaded driver and skip auto-detect by typing either
<br>
make ARCH=arm
<br>
make ARCH=$(arch)
<br>
make ARCH=armv6l 
<br>
make ARCH=armv7l
<br>
some drivers have the RPI compatibility built-in; for those let it auto-detect the proc. and just type (make)
<br>
good luck !

