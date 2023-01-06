# create-etcher-image

* This tool creates block device images compressed with xz.
* The images by default are shrunken and if the OS is systemd based, on first boot the disks will resize to the new sdcard size.
* The capture removes logs, apt archives, dhcp leases, ssh hostkeys and users bash history.

# Usage

`./capture-sdcard.sh <block device> <full path to image file with name>`

A block device could be something like `/dev/sdb`.

## Prerequisites

Debian / Ubuntu

`sudo apt install -y git xz-utils`


## Example


`./capture-sdcard.sh /dev/sdc /tmp/test-image.img`

Using the block device /dev/sdc, capture a compressed image file to `/tmp/test-image.img.xz`.

# Credit

PiShrink - https://github.com/Drewsif/PiShrink 

Balena Etcher Discussion - https://github.com/balena-io/etcher/issues/266

# Contributing

Please create new issues for bugs and features. Pull requests for new features and bug fixes are more than welcome!
