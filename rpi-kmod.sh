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
clear
echo ""
echo "RPI-Wifi-DRVr: v1.0"
echo ""
echo "This script is a quick-fix so that you dont have to compile the whole"
echo "Raspbian Linux kernel on this very machine; It's a solution for the"
echo "purpose of installing a kernel driver or to build kernel modules, such"
echo "as a USB Wifi card Driver/etc. The minimalistic Raspbian Image does not"
echo "include it's source code, or linux headers for make(GCC,CPP) nor 3rd-party"
echo "drivers. These pre-compiled headers are not my own, but enjoy building your"
echo "own modules and kernel drivers without wasting valuable time."
echo ""
sleep 8
echo "Installing two pre-required items for the script....(bc,dkms)"
echo ""
sudo apt-get install -y bc dkms
echo ""
echo ""
sleep 4
clear
echo "Step 1: Updating your repo,URLs,Distro(dep)packages, Query Installed Kernel."
echo ""
echo ""
sudo apt-get update --fix-missing && sudo apt-get upgrade
echo ""
echo ""
echo ""
sleep 10
clear
echo "Now, the hard part..Updating to the latest Raspbian Kernel version available."
echo "============================================================================="
echo "Your current kernel version is : "`uname -r`
echo "CPU_Architecture : "`arch`
if [ $(arch) = "armv6l" ]; then
echo "This is a Single-Core Proc.(armv6l) ,meaning a Raspberry Pi 0/0W/1/1B+/(orig.)2/A+/B+"
echo "Kernel Release no.: "$(uname -v|cut -b 1-6) $(echo "    pushed: -> ") $(uname -v|cut -b 10-17) $(uname -v|cut -b 30-35)
else
echo "This is a Quad-Core Proc. (armv7l), meaning a Raspberry Pi 2/3/3B"
echo "Kernel Release no.: "$(uname -v|cut -b 1-6) $(echo "    pushed: -> ") $(uname -v|cut -b 10-17) $(uname -v|cut -b 35-38)
fi
web_ver=" "
web_ver7=" "
echo "(Installed) Kernel hash : "$(vcgencmd version |grep 'version'|echo `cut -b 8-66`)
if [ $(arch) = "armv6l" ]; then
web_ver=$(curl -s https://raw.githubusercontent.com/Hexxeh/rpi-firmware/master/uname_string)
echo "Current web release : "$(echo $web_ver|cut -b 14-22)$(echo $web_ver|cut -b 111-116) $(echo " (Available)  | You're on: "`uname -r`) $(echo "  "`uname -v|cut -b 1-6`)
else
web_ver7=$(curl -s https://raw.githubusercontent.com/Hexxeh/rpi-firmware/master/uname_string7)
echo "Current web release : "$(echo $web_ver7|cut -b 14-25)$(echo $web_ver7|cut -b 114-120) $(echo " (Available)  | You're on: "`uname -r`) $(echo "  "`uname -v|cut -b 1-6`)
fi
echo "============================================================================"
echo ""
echo "!!!Be aware of the CPU architecture and the kernel version, it varies between"
echo "Raspberry Pi types/models (i.e.: RPI 0/1/2/3)! --RPI single cores are [armv6l]"
echo "and the quad cores are [armv7l], each uses different kernel versions when"
echo "booting Raspbian, if you placed this SD-card on a single core RPI after running"
echo "this script on a quad core RPI; the wifi driver will not start! due to the"
echo "change of kernel to fix it run this script on the single core RPI or vise versa"
echo "if it was a single core originally run it on a quad core. SIMPLE!- No harm done,"
echo "just be aware onto why it happen to get why it failed, Basically you have to"
echo "make the driver for each individual proc./kernel combo."
echo ""
echo ""
sleep 35
clear
echo "Step 2: (rpi-update) will start now....."
echo ""
sleep 3
sudo rpi-update
echo ""
echo ""
echo "If it updated the systems firmware in-anyway, You have to Restart your system"
echo "Remember to re-run this script. Nothing will brake just re-run after the reboot."
echo "to restart the RPI, quit here by pressing Ctrl + C"
echo "then type-- sudo reboot  ....on the shell. "
echo ""
sleep 10
read -p Ctrl+C\ to\ EXIT\ or\ press\ Enter\ to\ continue A
sleep 2
echo ""
echo ""
clear
echo "Downloading Install package..."
echo ""
sleep 3
# downloading needed kernel headers
curl $(echo  68747470733A2F2F7777772E6E696B73756C612E6875742E66692F7E6D686969656E6B612F5270692F6C696E75782D686561646572732D7270692F6C696E75782D686561646572732D|xxd -r -p)`uname -r`_`uname -r``echo 2d325f61726d68662e646562|xxd -r -p` -O
sleep 30
echo ""
clear
echo "Step 3: Installing the downloaded kernel header package for this revision..."
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
clear
echo "============================================================================="
echo "                         Kernel Headers Installed.                           "
echo "============================================================================="
echo ""
echo "System is Ready...now go find that linux driver for that non-raspbian-included,"
echo "Wifi Card/device etc, I.E. I like the RTL8812AU with 5GHZ support (ver.5.2.9).."
echo "git clone https://github.com/dernyn/rtl8812au"
echo ""
echo "Some drivers have been setup to detect the proc. arch.(within the Makefile)"
echo "by just typing (make) but to avoid conflict or errors with (make) try this."
echo ""
echo "Go to the path of your downloaded driver I.E."
echo "cd rtl8812au"
echo "to skip the auto-detect by typing either:"
echo "(make ARCH=arm) (make ARCH=armv6l) or (make ARCH=armv7l)"
echo "depending on proc. if you forgot your proc. then"
echo "-- make ARCH=$(arch) ,this works too." 
echo ""
echo "To perform the installation type:"
echo "(make install ARCH=arm) or (make install ARCH=armv6l/armv7l)"
echo " make install ARCH=$(arm) , also works"
echo ""
echo "--------------------------------------------------------------------------"
echo "To install the driver without the make command, type:"
echo "$ sudo cp 8812au.ko /lib/modules/`uname -r`/kernel/drivers/net/wireless"
echo "$ sudo depmod -a"
echo "$ sudo modprobe 8812au"
echo "--------------------------------------------------------------------------"
echo "now you can restart if you like...."
echo "or continue with the DKMS install procedures, if you want!"
echo "but...the wifi should be already working! if you had no errors"
echo ""
echo "Script is Complete."
