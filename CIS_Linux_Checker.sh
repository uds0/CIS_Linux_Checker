#!/bin/bash

# VARIABLES
USER=$(whoami)
ID=$(id)
FILENAME=$1



UNUSED_FILE_SYSTEMS="cramfs freevxfs jffs2 hfs hfsplus squashfs udf fat"


function usage {
				echo -e "\033[0;33mLinux CIS Checker script written by David Shanahan @ds0yo"
				echo "$0 <filename>"
				
}

function unused_file_systems {
		local COUNT=1
		for i in $UNUSED_FILE_SYSTEMS; do
			modprobe -n -v $i > $FILENAME.1_1_1_$COUNT.output
			lsmod| grep $i >> $FILENAME.1_1_1_$COUNT.output
			let COUNT=COUNT+1
		done


}


if [ -z $1 ]; then
	   usage
elif [ $EUID -ne 0 ]; then
		echo -e "\033[0;31m[!] Script not running as root! Is $USER in sudoers?"
else
 echo "Linux Check Commencing..."		
 echo "1.1.1 Disable unused filesystems"
 unused_file_systems
fi


