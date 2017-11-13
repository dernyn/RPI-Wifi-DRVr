#!/bin/sh
#
# RPI-Wifi-DRVr
#  by Dernyn (JD)
#  https://twitter.com/d_e_r_n_y_n
#  11/11/2017

sudo JUST_CHECK=1 rpi-update>/dev/null
echo -e "This script is a fix so that you dont have to compile the whole Raspbian Linux kernel on this machine, just for the purpose of installing a driver,such as USB Wifi card Driver/etc."
echo ""
sleep 10
echo -e "Installing 2 required items for the script...."
echo ""
echo ""
sudo apt-get install -y bc dkms
echo ""
echo ""
sleep 10
echo -e "Updating your repository urls and distro packages"
echo ""
echo ""
sudo apt-get update && sudo apt-get upgrade
echo ""
echo ""
echo ""
sleep 20
echo -e "Now the hard part.. Updating to the latest Raspbian Kernel version available."
echo -e "Your current kernel version : "`uname -r``echo -e "     CPU_Architecture : "``uname -m`
echo -e "Installed Raspbian Version hash : "`vcgencmd version`
echo ""
echo -e "Latest Version : "`curl -s https://github.com/Hexxenh/rpi-firmware/commit/$(cat /boot/.firmware_revision)|grep '<title>Kernel: Bump to'|cut -b24-30`
sleep 40
echo ""
echo ""
echo -e "!!!Be aware of the CPU architecture and the kernel version for each, it varies between Raspberry Pi types/versions(i.e RPI 0/1/2/3)!"
echo -e "RPI single cores are [armv61] and the quad core and others are [armv71], they use different kernel versions within Raspbian."
echo -e "if you placed this SD-card on a single core RPI after running this script on a quad core RPI; the wifi driver will not start!"
echo -e "simply run this script on the single core RPI or vise versa if it was a quad core RPI originally, No harm done, just be aware onto why it happen and didn't work"
echo ""
echo ""
sleep 45
sudo rpi-update
sleep 30
echo ""
echo ""
echo -e "You have to Restart your system after this proccess, if it updated the systems firmware in anyway."
echo -e "If that's the case Do not worry just re-run this script after the reboot. (all is fine) Stop here by pressing Ctrl + C and type sudo reboot."
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
echo -e "Wait a minute or two for the downloading proccess"
sleep 250
echo ""
echo -e "Installing kernel header packages..."
echo ""
echo ""
