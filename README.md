# Overview

* This script creates block device images compressed with xz.
* The images by default are shrunken and if the OS is systemd based, on first boot the disks will resize to the new sdcard size.
* The capture removes logs, apt archives, dhcp leases, ssh hostkeys and users bash history.

## Example execution

`./capture-sdcard.sh /dev/sdc /tmp/test-image.img`

The resulting image file would be `/tmp/test-image.img.xz`
