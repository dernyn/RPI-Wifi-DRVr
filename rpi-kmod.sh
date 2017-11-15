#!/bin/sh
#
# RPI-Wifi-DRVr
#  by Dernyn (JD)
#  https://twitter.com/d_e_r_n_y_n
#  11/11/2017

#run this for proper installion of the script.
# $  sudo mv ./rpi-kmod.sh /usr/bin/rpi-kmod
# $  sudo chmod +x /usr/bin/rpi-kmod
#  rpi-kmod
#this will run from outside the git clone.

echo ""
echo "RPI-Wifi-DRVr: v1.0"
echo ""
echo "This script is a quick-fix so that you dont have to compile the whole Raspbian Linux kernel on this very machine;"
echo "it's a solution for the purpose of installing a kernel driver/build kernel modules, such as a USB Wifi card Driver/etc."
echo "the minimalistic Raspbian Image does not include it's source code, or linux headers for make(GCC,CPP) nor 3rd party drivers."
echo "these pre-compiled headers are not made by me, but enjoy building your own modules and kernel drivers without wasting valuable time."
echo ""
sleep 10
echo "Installing 2 required items for the script...."
echo ""
echo ""
sudo apt-get install -y bc dkms
echo ""
echo ""
sleep 2
echo "Updating your repository urls and distro packages"
echo ""
echo ""
sudo apt-get update && sudo apt-get upgrade
echo ""
echo ""
echo ""
clear
echo "Now the hard part.. Updating to the latest Raspbian Kernel version available."
echo "Your current kernel version is : "`uname -r`
echo "CPU_Architecture : "`uname -m`
if [ $(uname -m)=="armv61" ]
then
echo "This is a Single-Core Proc. , meaning a Raspberry Pi 0/0W/1/1B+/(orig.)2/A+/B+"
else
echo "This is a Quad-Core Proc. , meaning a Raspberry Pi 2/3/3B
fi
echo "Kernel Release no.: "$(uname -v|cut -b 1-6) $(echo "    pushed: -> ") $(uname -v|cut -b 10-17) $(uname -v|cut -b 30-35)
echo "(Installed) Kernel hash : "$(vcgencmd version |grep 'version'|echo `cut -b 8-66`)
if [ $(uname -m)=="armv61" ]
then 
echo "Current release Version : "$(curl -s https://raw.githubusercontent.com/Hexxeh/rpi-firmware/master/uname_string|cut -b 14-22)$(curl -s https://raw.githubusercontent.com/Hexxeh/rpi-firmware/master/uname_string|cut -b 111-116) $(echo " (Available)  | You're on: "`uname -r`) $(echo "  "`uname -v|cut -b 1-6`)
else
echo "Current release Version : "$(curl -s https://raw.githubusercontent.com/Hexxeh/rpi-firmware/master/uname_string7|cut -b 14-25)$(curl -s https://raw.githubusercontent.com/Hexxeh/rpi-firmware/master/uname_string7|cut -b 114-120) $(echo " (Available)  | You're on: "`uname -r`) $(echo "  "`uname -v|cut -b 1-6`)
fi
echo ""
echo ""
echo "!!!Be aware of the CPU architecture and the kernel version, it varies between Raspberry Pi types/versions (i.e.: RPI 0/1/2/3)!"
echo "RPI single cores are [armv61] and the quad core and others are [armv71], they use different kernel versions within Raspbian for each."
echo "if you placed this SD-card on a single core RPI after running this script on a quad core RPI; the wifi driver will not start!"
echo "simply run this script on the single core RPI or vise versa if it was a single core originally run it on a quad core."
echo "No harm done, just be aware onto why it happen and why it failed, you have to make the driver for each individual proc. type if you swap SD."
echo ""
echo ""
sleep 35
sudo rpi-update
sleep 10
echo ""
echo ""
echo "If it updated the systems firmware in-anyway, You have to Restart your system after this proccess, and re-run this script."
echo "Do not worry just re-run this script after the reboot. (all is fine) to restart Stop here by pressing Ctrl + C and type - sudo reboot "
echo ""
sleep 20
read -p Ctrl+C\ to\ EXIT\ or\ press\ Enter\ to\ continue A
sleep 2
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
echo "Wait a minute or two for the downloading proccess..."
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
echo "I.E. I like the RTL8812AU with 5GHZ support ver.5.2 you can get it by-> git clone https://github.com/mk-fg/rtl8812au"
echo "cd rtl8812au"
echo "Some driver packages have been setup to detect the proccessor(within the Makefile), by just typing (make) but to avoid conflict and errors with make just follow the guide below..."
echo "Go to the path of your downloaded driver and skip auto-detect by typing either (make ARCH=arm) (make ARCH=armv61) or (make ARCH=armv71)"
echo ""
echo "TO perform the installation type (make install ARCH=arm) or (make install ARCH=armv61/armv71)"
echo "if not to avoid the make command, I.E. $ sudo cp 8812au.ko /lib/modules/`uname -r`/kernel/drivers/net/wireless
echo "$ sudo depmod -a"
echo "$ sudo modprobe 8812au"
echo "now you can restart, after this you can follow your dkms install procedures, if you want!...wifi show be already working"
echo "Script is Complete."
