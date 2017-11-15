# RPI-Wifi-DRVr
This script allows an easy way to Install and Compile non-RPI Supported Wi-fi Drivers on the Raspberry PI, Mostly a Kernel header installer script which allows the user to compile kernel Modules like wifi drivers in a fast manner without having to compile the Raspbian Kernel Source.

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
cd RPI-Wifi-DRVr
<br>
sh rpi-kmod.sh

