# create-etcher-image

* This tool creates block device images (full device, not specific partition) compressed with xz.
* The images by default are shrunken and if the OS is systemd based, on first boot the disks will resize to the new sdcard size.
* The capture removes logs, apt archives, dhcp leases, ssh hostkeys and users bash history.

# Usage

`./capture-sdcard.sh <block device> <absolute/relative path to image file with name>`

A block device could be something like `/dev/sdb`.

## Prerequisites

Debian / Ubuntu

`sudo apt install -y git xz-utils bash`

## Example

The example assumes a full disk is at `/dev/sdc` and it contains a ext4 partition which will be shrunk.

`./capture-sdcard.sh /dev/sdc test-image.img`

Using the block device /dev/sdc, capture a compressed image file to `test-image.img.xz`.

Example output ("Syspreping" may have errors as the pishrink script is looking for a number of things to clean up)
```
 ######### ### Capturing RAW disk ### #########
122814464 bytes (123 MB, 117 MiB) copied, 30 s, 4.0 MB/s
29+1 records in
29+1 records out
122814464 bytes (123 MB, 117 MiB) copied, 30.4175 s, 4.0 MB/s
 ######### Shrinking disk and compressing with xz #########
pishrink.sh v0.1.2
pishrink.sh: Gathering data ...
pishrink.sh: /etc not found, autoexpand will not be enabled ...
pishrink.sh: Syspreping: Removing logs, apt archives, dhcp leases, users bash history, and ssh hostkeys ...
find: '/tmp/tmp.oheNV2rjAU/home/': No such file or directory
ln: failed to create symbolic link '/tmp/tmp.oheNV2rjAU/etc/systemd/system/multi-user.target.wants/regenerate_ssh_host_keys.service': No such file or directory
pishrink.sh: Checking filesystem ...
/dev/loop0: 11/29728 files (9.1% non-contiguous), 1977/29728 blocks
resize2fs 1.45.5 (07-Jan-2020)
pishrink.sh: Shrinking filesystem ...
resize2fs 1.45.5 (07-Jan-2020)
Resizing the filesystem on /dev/loop0 to 6988 (4k) blocks.
The filesystem on /dev/loop0 is now 6988 (4k) blocks long.

pishrink.sh: Shrinking image ...
pishrink.sh: Using xz on the shrunk image ...
pishrink.sh: Shrunk /home/ubuntu/create-etcher-image/test.img.xz from 118M to 5.6K ...
 ######### COMPLETE #########
```

# Credit

PiShrink - https://github.com/Drewsif/PiShrink 

Balena Etcher Discussion - https://github.com/balena-io/etcher/issues/266

# Contributing

Please create new issues for bugs and features. Pull requests for new features and bug fixes are more than welcome!
