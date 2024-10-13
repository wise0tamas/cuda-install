#!/bin/bash
# purpose:	install CUDA (tested on Debian 12 only)
# date:		2024.10.03.
# developer:	tamas.vizi@dlabs.hu

#-1- functions -#
help_() {
	#
	echo "Usage: $0 [phase1|phase2|help]" ;
	echo "" ;
	echo "  $0 phase1 : upgrade system before setting up nvidia." ;
	echo "  $0 phase2 ; setup and install nvidia drivers, then CUDA." ;
	echo "  $0 help : view this help." ;
	echo "" ;
}
phase1() {
	#
	echo "PHASE 1 starting... refreshing system..." ;
	sudo apt update ;
	sudo apt full-upgrade ;
	#
	echo "installing repo manager..." ;
	sudo apt install software-properties-common ;
	#
	echo "include common and non-free-firmware components manually in all lists... (quit vim with :qa after writing the modifications) " ;
	sudo vim.tiny -Rp /etc/apt/sources.list{,.d/*.{list,sources}}
	#
	echo "refreshing, installing and purging again..." ;
	sudo apt update ; 
	sudo apt full-upgrade ; 
	sudo apt install apt-trasport-https build-essential ca-certificates cron curl dirmngr dkms dos2unix gcc git-all 
	sudo apt autoremove --purge ;
	#
	echo "## PHASE 1 done, please, reboot. ##" ;
}

phase2() {
	#
	echo "PHASE 2 starting..." ;
	#
	echo "obtaining NVidia apt key..." ;
	curl -fSsL https://developer.download.nvidia.com/compute/cuda/repos/debian12/x86_64/3bf863cc.pub | sudo gpg --dearmor | sudo tee /usr/share/keyrings/nvidia-drivers.gpg > /dev/null 2>&1
	#
	echo "creating apt list..." ;
	echo 'deb [signed-by=/usr/share/keyrings/nvidia-drivers.gpg] https://developer.download.nvidia.com/compute/cuda/repos/debian12/x86_64/ /' | sudo tee /etc/apt/sources.list.d/nvidia-drivers.list
	#
	echo "update then install nvidia/cuda driver packages..." ;
	sudo apt update ;
	sudo apt install nvidia-driver=560.35.03-1 ;
	sudo apt install cuda-drivers-560 ;
	#
	echo "install CUDA package(s)..." ;
	sudo apt install cuda;
	#
	echo "## PHASE 2 done, please, reboot. ##" ;
}

#-2- main() -#
case $1 in
	phase1)	phase1 ;;
	phase2)	phase2 ;;
	help|*) help_ ;;
esac

