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
echo ""
sudo apt-get install -y bc dkms
echo ""
echo ""
sleep 4
clear
echo "Step 1: Updating your repository urls and distro packages, identifying your Kernel Install."
echo ""
echo ""
sudo apt-get update --fix-missing && sudo apt-get upgrade
echo ""
echo ""
echo ""
sleep 10
clear
echo "Now, the hard part.. Updating to the latest Raspbian Kernel version available."
echo ""
echo "Your current kernel version is : "`uname -r`
echo "CPU_Architecture : "`arch`
case $(arch) in
  armv61)
echo "This is a Single-Core Proc. (armv61) , meaning a Raspberry Pi 0/0W/1/1B+/(orig.)2/A+/B+"
  armv71)
echo "This is a Quad-Core Proc. (armv71), meaning a Raspberry Pi 2/3/3B"
esac
export web_ver=" "
export web_ver7=" "
echo "Kernel Release no.: "$(uname -v|cut -b 1-6) $(echo "    pushed: -> ") $(uname -v|cut -b 10-17) $(uname -v|cut -b 30-35)
echo "(Installed) Kernel hash : "$(vcgencmd version |grep 'version'|echo `cut -b 8-66`)
case $(arch) in
  armv61)
export web_ver=$(curl -s https://raw.githubusercontent.com/Hexxeh/rpi-firmware/master/uname_string)
echo "Current release Version : "$(echo $web_ver|cut -b 14-22)$(echo $web_ver|cut -b 111-116) $(echo " (Available)  | You're on: "`uname -r`) $(echo "  "`uname -v|cut -b 1-6`)
  armv71)
export web_ver7=$(curl -s https://raw.githubusercontent.com/Hexxeh/rpi-firmware/master/uname_string7)
echo "Current release Version : "$(echo $web_ver7|cut -b 14-25)$(echo $web_ver7|cut -b 114-120) $(echo " (Available)  | You're on: "`uname -r`) $(echo "  "`uname -v|cut -b 1-6`)
esac
echo ""
echo ""
echo "!!!Be aware of the CPU architecture and the kernel version, it varies between"
echo "Raspberry Pi types/models (i.e.: RPI 0/1/2/3)! --RPI single cores are [armv61]"
echo "and the quad cores are [armv71], each uses different kernel versions when booting"
echo "Raspbian, if you placed this SD-card on a single core RPI after running this script"
echo "on a quad core RPI; the wifi driver will not start! due to the change of kernel"
echo "to fix it run this script on the single core RPI or vise versa if it was a single core"
echo "originally run it on a quad core. SIMPLE!- No harm done, just be aware onto why it happen"
echo "to get why it failed, Basically you have to make the driver for each individual proc./kernel"
echo ""
echo ""
echo "Step 2: (rpi-update) will start now....."
sleep 40
sudo rpi-update
sleep 10
echo ""
echo ""
echo "If it updated the systems firmware in-anyway, You have to Restart your system after this proccess"
echo "Remember to re-run this script. Nothing will brake just re-run this script after the reboot."
echo "to restart the RPI, Stop here by pressing Ctrl + C and type - sudo reboot....on the shell. "
echo ""
sleep 20
read -p Ctrl+C\ to\ EXIT\ or\ press\ Enter\ to\ continue A
sleep 2
echo ""
echo ""
clear
echo "Wait a minute or two for the downloading proccess..."
echo ""
sleep 5
# downloading your current kernel headers
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
sudo ln -s arm armv61
sleep 10
sudo ln -s arm armv71
sleep 10
echo ""
clear
echo "================================================================================================="
echo "                                     Kernel Headers Installed.                                   "
echo "================================================================================================="
echo ""
echo "System is Ready...now go find that linux driver for that non-raspbian-included Wifi Card/etc."
echo "I.E. I like the RTL8812AU with 5GHZ support ver.5.2.9 try --> git clone https://github.com/dernyn/rtl8812au"
echo ""
echo "Some driver packages have been setup to detect the proccessor(within the Makefile), by just typing (make)"
echo "but to avoid conflict or errors with make just follow the guide below..."
echo ""
echo "Go to the path of your downloaded driver I.E."
echo "cd rtl8812au"
echo "skip the auto-detect by typing either (make ARCH=arm) (make ARCH=armv61) or (make ARCH=armv71) depending on proc."
echo "if you forgot your proc. then ---------- make ARCH=$(arch) ,works too." 
echo ""
echo "To perform the installation type (make install ARCH=arm) or  (make install ARCH=armv61/armv71)"
echo " make install ARCH=$(arm) , also works"
echo ""
echo "-------------------------------------------------------------------------------------------------"
echo "to install the driver without the make command, type: $ sudo cp 8812au.ko /lib/modules/`uname -r`/kernel/drivers/net/wireless
echo "$ sudo depmod -a"
echo "$ sudo modprobe 8812au"
echo "-------------------------------------------------------------------------------------------------"
echo "now you can restart if you like...., or continue with the dkms install procedures, if you want!...the wifi show be already working!"
echo ""
echo "Script is Complete."
