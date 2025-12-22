#!/usr/bin/env bash

# Error out if any steps fail
set -e

if [ "$#" -ne 2 ]; then
    echo "Error: This script requires exactly 2 arguments."
    echo "Syntax: $0 <block device> <absolute/relative path to image file with name>"
    echo "  See readme for details."
    exit 1
fi

# In format of "/dev/<block device>", i.e., /dev/sdb
DISK="$1"
# Get absolute path for image name
IMG_NAME=$(realpath "$2")

function status ()
{
   COLOR='\033[0;32m'
   NC='\033[0m' # No Color
   printf "${COLOR} ######### $1 #########${NC}\n"
}
function error ()
{
   COLOR='\033[0;31m'
   NC='\033[0m' # No Color
   printf "${COLOR} ######### $1 #########${NC}\n"
}

if [ ! -e "pishrink" ]; then
   git clone https://github.com/matthew-l-weber/PiShrink.git pishrink
else
   cd pishrink || exit 1
   git pull
   cd ..
fi

status "### Capturing RAW disk ###"
if [ ! -e "${DISK}" ]; then
   error "Disk doesn't exist, exiting..."
   exit 1
fi
if [ ! -e "${IMG_NAME}" ]; then
   sudo dd if="${DISK}" of="${IMG_NAME}" bs=4M status=progress
   sudo chmod 777 "${IMG_NAME}"
else
   error "Image file exists, not overwriting and skipping capture..."
   exit 1
fi

# Usage: https://github.com/matthew-l-weber/PiShrink#usage
# NOTE: The -p option may need to be dropped depending on the type of OS on the card.  
#       I.e. it expects a systemd based OS and removes logs, apt archives, dhcp leases,
#       ssh hostkeys and users bash history.
status "Shrinking disk and compressing with xz"
cd pishrink || exit 1
sudo ./pishrink.sh -Zrpa "${IMG_NAME}"

status "COMPLETE"
