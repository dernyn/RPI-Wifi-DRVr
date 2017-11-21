# RPI-Wifi-DRVr
This script allows an easy way to Install and Compile non-Raspbian-Included Wi-fi Drivers on any Raspberry PI (RPI), It's Mostly a Kernel header installer script which allows the user to compile kernel Modules, made specially for wifi drivers to install in a fast manner without having to compile the Raspbian Kernel Source after every firmware release/kernel update (rpi-update).
<br>
This Kernel Headers are pre-compiled and are 3rd-party distributed, this installs it and gets you ready to build any kernel module, particularly wifi drivers, but it can be used for any kernel module or driver build with (make) in raspbian (all versions).

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
<h1>Obtain your Chipset/Manufacture's Linux driver</h1>
<br>
try to check compatibility and kernel version requirements.
<br>
but mainly go to the path of your extracted .tar/.zip/.rar----etc. downloaded driver and skip auto-detect by typing either (make ARCH=arm) (make ARCH=$(arch) (make ARCH=armv6l) or (make ARCH=armv7l) , some drivers have the RPI compatibility built-in; for those let it auto-detect the proc. and just type (make)
<br>
good luck !

