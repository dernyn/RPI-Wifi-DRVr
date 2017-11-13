#!/bin/sh
#
# RPI-Wifi-DRVr
#  by Dernyn (JD)
#  https://twitter.com/d_e_r_n_y_n
#  11/11/2017

echo -n "This script is a fix so that you dont have to compile the whole Raspbian Linux kernel on this machine, just for the purpose of installing a driver,such as USB Wifi card Driver/etc."
echo ""
sleep 10
echo -n "Installing 2 requirements for the script...."
echo ""
echo ""
sudo apt-get install -y bc dkms
echo ""
echo ""
sleep 10
echo -n "Updating your repository urls and distro packages"
echo ""
echo ""
sudo apt-get update && sudo apt-get upgrade
echo ""
echo ""
echo ""
sleep 20
echo -n "Now the hard part Updating to the latest Raspbian Kernel version available."
echo -n "Your current kernel version : "`uname -r``echo -e "     Proc_Architecture : "``uname -m`
echo -n "Installed Version hash : "`vcgencmd version`
echo ""
sudo JUST_CHECK=1 rpi-update>/dev/null
echo -n "Latest Version : "
curl -s https://github.com/Hexxenh/rpi-firmware/commit/$(cat /boot/.firmware_revision)|grep '<title>Kernel: Bump to'|cut -b24-30
sleep 40
echo ""
echo ""
echo -n "be aware of the architecture and the kernel version, it varies between Raspberry Pi types/versions(i.e RPI 0/1/2/3)!!!!!!"
echo -n "RPI single cores are armv61 and the quad core and others are armv71, and they use different kernel versions"
echo -n "if you place this SD-card on a single core after running this script on a quad core; the wifi driver will not start!"
echo -n "simple run this script on the single core or vise versa if it was a quad core originally, there is no harm done here, just be aware onto why is not working."
echo ""
echo ""
sleep 45
sudo rpi-update
sleep 30
echo ""
echo ""
echo -n "You have to Restart your system after this proccess, if you dont have the most up to date kernel version and it updated the system.
echo -n "if so Do not worry just re-run this after the reboot. it will be just fine. Stop here by pressing Ctrl + C and type sudo reboot."
echo ""
sleep 20
read -p "Ctrl + C to EXIT or any key to continue... " -n1 -s
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
sleep 25
# downloading your current kernel headers
wget -nv $(echo  68747470733A2F2F7777772E6E696B73756C612E6875742E66692F7E6D686969656E6B612F5270692F6C696E75782D686561646572732D7270692F6C696E75782D686561646572732D|xxd -r -p)`uname -r`_`uname -r``echo 2d325f61726d68662e646562|xxd -r -p`
sleep 150
echo -n "Wait a minute or two for the downloading proccess"
sleep 250
echo ""
echo -n "Installing kernel header packages..."
echo ""
echo ""
