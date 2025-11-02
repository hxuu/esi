# Raid Disks

Ensure `mdadm` is intalled using:

```bash
➜ pacman -S mdadm
```

## References

- https://linuxhandbook.com/dev-zero/
- https://itsfoss.com/loop-device-linux/
- https://www.golinuxcloud.com/losetup-command-in-linux/

## TP2 Solution

### Initial Steps

1. Create two disk (simulation of disks)

We'll use the dd command.

> [!TIP]
> The /dev/zero is a dummy file that is used to create files filled with zeroes.

```bash
➜ dd if=/dev/zero of=disk1.img bs=1M count=100
100+0 records in
100+0 records out
104857600 bytes (105 MB, 100 MiB) copied, 0.135684 s, 773 MB/s
```

This will create two files called disk1 and disk2 .img respectively. Everything in linux is a file,
so we can map those files to virtual block devices so we can access them as blocks.

```bash
ESI/os/tp2
➜ sudo losetup -Pf disk1.img
[sudo] password for hxuu:

ESI/os/tp2
➜ lsblk
NAME        MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
loop0         7:0    0   100M  0 loop
nvme0n1     259:0    0 238.5G  0 disk
├─nvme0n1p1 259:1    0  68.4G  0 part /
├─nvme0n1p2 259:2    0 169.9G  0 part /home
└─nvme0n1p3 259:3    0   256M  0 part /boot/efi
```

- `-P`: Forces the kernel to scan partition table (useful later)
- `-f`: Automatically find the first available free loop device.

2. Partition the disks (2 partitions in each disk)

```bash
➜ sudo fdisk /dev/loop0

Welcome to fdisk (util-linux 2.41).
Changes will remain in memory only, until you decide to write them.
Be careful before using the write command.

Device does not contain a recognized partition table.
Created a new DOS (MBR) disklabel with disk identifier 0xc06f540a.

Command (m for help):
```

After running `lsblk`, the results should be:

```bash
➜ lsblk
NAME        MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
loop0         7:0    0   100M  0 loop
├─loop0p1   259:4    0    50M  0 part
└─loop0p2   259:5    0    49M  0 part
loop1         7:1    0   100M  0 loop
├─loop1p1   259:6    0    50M  0 part
└─loop1p2   259:7    0    49M  0 part
```

### Creation RAID 0

```bash
➜ sudo mdadm -Cv /dev/md0 --level=0 --raid-devices=2 /dev/loop0p1 /dev/loop1p1
mdadm: chunk size defaults to 512K
mdadm: Defaulting to version 1.2 metadata
mdadm: array /dev/md0 started.
```

`lsblk` result will give:

```bash
➜ lsblk
NAME        MAJ:MIN RM   SIZE RO TYPE  MOUNTPOINTS
loop0         7:0    0   100M  0 loop
├─loop0p1   259:4    0    50M  0 part
│ └─md0       9:0    0    96M  0 raid0
└─loop0p2   259:5    0    49M  0 part
loop1         7:1    0   100M  0 loop
├─loop1p1   259:6    0    50M  0 part
│ └─md0       9:0    0    96M  0 raid0
└─loop1p2   259:7    0    49M  0 part
```

### Creation RAID 1

> A bitmap in RAID is a small on-disk structure that keeps track of which parts of the RAID array have been written to.

```bash
➜ sudo mdadm -Cv /dev/md1 --level=1 --raid-devices=2 /dev/loop0p2 /dev/loop1p2
To optimalize recovery speed, it is recommended to enable write-indent bitmap, do you want to enable it now? [y/N]? y
mdadm: Note: this array has metadata at the start and
    may not be suitable as a boot device.  If you plan to
    store '/boot' on this device please ensure that
    your boot-loader understands md/v1.x metadata, or use
    --metadata=0.90
mdadm: size set to 49152K
Continue creating array [y/N]? y
mdadm: Defaulting to version 1.2 metadata
mdadm: array /dev/md1 started.
```

`lsblk` result will give:

```bash
➜ lsblk
NAME        MAJ:MIN RM   SIZE RO TYPE  MOUNTPOINTS
loop0         7:0    0   100M  0 loop
├─loop0p1   259:4    0    50M  0 part
│ └─md0       9:0    0    96M  0 raid0
└─loop0p2   259:5    0    49M  0 part
  └─md1       9:1    0    48M  0 raid1
loop1         7:1    0   100M  0 loop
├─loop1p1   259:6    0    50M  0 part
│ └─md0       9:0    0    96M  0 raid0
└─loop1p2   259:7    0    49M  0 part
  └─md1       9:1    0    48M  0 raid1
```

> That ~1 MB difference you're seeing between loop1p2 (49 MB) and md1 (48 MB) is very likely used for the write-intent bitmap.

### File System

Before accessing any block device, you have to format it first, because otherwise:

```bash
✗ sudo mount /dev/md0 /mnt
mount: /mnt: wrong fs type, bad option, bad superblock on /dev/md0, missing codepage or helper program, or other error.
       dmesg(1) may have more information after failed mount system call.
```

If we try to make a filesystem without specifying the type, this happens:

```bash
➜ sudo mkfs /dev/md0
mke2fs 1.47.2 (1-Jan-2025)
Discarding device blocks: done
Creating filesystem with 98304 1k blocks and 24576 inodes
Filesystem UUID: bed9a975-c703-4004-9e4d-12c949d2dcbc
Superblock backups stored on blocks:
        8193, 24577, 40961, 57345, 73729

Allocating group tables: done
Writing inode tables: done
Writing superblocks and filesystem accounting information: done
```

To view the type of the filesystem, type `lsblk -f` (-f outputs info about filesystem)
