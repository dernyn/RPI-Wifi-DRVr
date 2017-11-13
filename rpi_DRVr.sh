#!/bin/sh
#
# RPI-Wifi-DRVr
#  by Dernyn (JD)
#  https://twitter.com/d_e_r_n_y_n
#  11/11/2017

echo RPI-Wifi-DRVr:`sudo JUST_CHECK=1 rpi-update>/dev/null`
echo "This script is a fix so that you dont have to compile the whole Raspbian Linux kernel on this very machine;"
echo "which is the other solution for the purpose of installing a kernel driver/build modules, such as a USB Wifi card Driver/etc."
echo "the minimalistic Raspbian Image does not include it's source code, linux headers for make(GCC,CPP) and a repository for drivers."
echo "these headers are not distribute/compiled by me, but enjoy building your own modules and kernel drivers without wasting valuable time."
echo ""
sleep 10
echo "Installing 2 required items for the script...."
echo ""
echo ""
sudo apt-get install -y bc dkms
echo ""
echo ""
sleep 7
echo "Updating your repository urls and distro packages"
echo ""
echo ""
sudo apt-get update && sudo apt-get upgrade
echo ""
echo ""
echo ""
sleep 10
echo "Now the hard part.. Updating to the latest Raspbian Kernel version available."
echo "Your current kernel version : "`uname -r``echo "     CPU_Architecture : "``uname -m`
echo "Installed Raspbian Version hash : "`vcgencmd version`
echo ""
echo "Latest Version : "`curl -s https://github.com/Hexxenh/rpi-firmware/commit/$(cat /boot/.firmware_revision)|grep '<title>'`sleep 6`|cut -b26-30
echo ""
echo ""
echo "!!!Be aware of the CPU architecture and the kernel version for each, it varies between Raspberry Pi types/versions(i.e RPI 0/1/2/3)!"
echo "RPI single cores are [armv61] and the quad core and others are [armv71], they use different kernel versions within Raspbian for each."
echo "if you placed this SD-card on a single core RPI after running this script on a quad core RPI; the wifi driver will not start!"
echo "simply run this script on the single core RPI or vise versa if it was a quad core RPI originally, No harm done, just be aware onto why it happen and why it failed"
echo ""
echo ""
sleep 35
sudo rpi-update
sleep 10
echo ""
echo ""
echo "You have to Restart your system after this proccess, if it updated the systems firmware in anyway."
echo "If that's the case Do not worry just re-run this script after the reboot. (all is fine) Stop here by pressing Ctrl + C and type sudo reboot."
echo ""
sleep 20
read -p 'Ctrl + C to EXIT or any key to continue... ' -n 1 -s
sleep 2
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
echo "Wait a minute or two for the downloading proccess"
echo ""
sleep 5
# downloading your current kernel headers
curl $(echo  68747470733A2F2F7777772E6E696B73756C612E6875742E66692F7E6D686969656E6B612F5270692F6C696E75782D686561646572732D7270692F6C696E75782D686561646572732D|xxd -r -p)`uname -r`_`uname -r``echo 2d325f61726d68662e646562|xxd -r -p` -O
sleep 30
echo ""
echo "Installing kernel header packages..."
echo ""
echo ""
sudo dpkg -i linux-headers-`uname -r`_`uname -r``echo 2d325f61726d68662e646562|xxd -r -p`
echo ""
echo "Adding minor changes to avoid error prompts from make..."
cd /usr/src/linux-headers-$(uname -r)/arch
sleep 20
sudo ln -s arm armv6l
sleep 10
sudo ln -s arm armv7l
sleep 10
echo ""
echo "Kernel Headers Installed."
echo ""
echo "System is Ready...now go find that linux driver for that non-supported Raspberry Pi Wifi Card/etc."
echo "rtl8812au seems to be a popular one....."
echo "Some driver packages have been setup to detect the proccessor(within the Makefile), by just typing (make) but to avoid conflict and errors with make just follow the guide below...
echo "Go to the path of your downloaded driver and type either (make ARCH=arm) (make ARCH=armv61) or (make ARCH=armv71)"
echo ""
echo -n "TO perform the installation type (make install ARCH=arm) or (make install ARCH=armv61/armv71)"
echo -n "Script is Done."
