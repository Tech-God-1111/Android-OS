# Android-OS

A lightweight Linux environment starter for older Android phones, beginning with the **Samsung Galaxy On Max (2017)**.

> This project installs a Debian userspace inside Android using Termux + proot-distro. It does **not** replace Android, unlock the bootloader, flash partitions, or require root.

## What it sets up

- Debian Linux in a PRoot container
- Basic command-line tools: Python 3, Git, curl, wget, nano, and htop
- Optional XFCE desktop over a localhost-only VNC server

## Requirements

- Android phone with a working internet connection
- Termux installed from a trusted source (recommended: F-Droid or the official Termux GitHub releases)
- Several GB of free storage; desktop packages need considerably more
- A charged phone and a stable Wi-Fi connection

Install Termux and open it. Do not use the outdated Play Store build.

## Install Debian

In Termux, download or clone this repository, then run:

```sh
pkg update && pkg upgrade
pkg install git
git clone https://github.com/Tech-God-1111/Android-OS.git
cd Android-OS
bash install.sh
```

The installer checks that it is running in Termux, installs proot-distro, installs Debian, and adds the basic tools. It is safe to run again. It does not replace Android or modify boot partitions.

## Optional XFCE desktop

After Debian is installed, from the repository directory in Termux run:

```sh
bash setup-desktop.sh
```

Start the desktop:

```sh
bash start-desktop.sh
```

Install a VNC viewer app on Android and connect to **127.0.0.1:5901** on the same phone. The VNC server is configured for localhost only; do not expose it to your Wi-Fi network. On first start, TigerVNC may ask you to create a VNC password.

Stop the desktop:

```sh
bash stop-desktop.sh
```

## Remove Android-OS Linux (reversible)

To remove the Debian environment and reclaim its storage, run this from the Android-OS directory in Termux:

```sh
bash uninstall.sh
```

The script requires you to type `REMOVE-DEBIAN` before it proceeds. It stops the optional VNC session and removes only the Debian container using `proot-distro remove debian`. This permanently deletes files and packages stored inside that Debian container, so copy out anything you want to keep first. It leaves Android, Termux, the Android-OS project folder, and other files outside Debian untouched. You can install Debian again later by running `bash install.sh`.

To simply stop the graphical desktop without uninstalling Linux, use `bash stop-desktop.sh`.

## Useful commands

Enter Debian at any time:

```sh
proot-distro login debian
```

Inside Debian:

```sh
python3 --version
uname -m
cat /etc/os-release
```

## Device compatibility notes

The Galaxy On Max is an older Android device. Available RAM, free storage, Android version, CPU ABI, and Termux compatibility affect performance. Debian in PRoot shares the Android kernel; it is not a full Linux boot and cannot provide kernel-level features that Android does not expose. Some hardware features and system services will not work like they do on a PC.

Check the device architecture in Termux with:

```sh
uname -m
getprop ro.product.cpu.abi
```

## Safety

- This project does not root the phone or modify Android boot partitions.
- Review scripts before running them.
- Keep VNC bound to localhost and use a strong VNC password.
- Package installation requires internet access and storage.

## Project status

**v0.1.1 — reversible Linux bootstrap prototype.** Debian CLI installation, optional XFCE/VNC setup, and an explicit uninstall script are provided. Device-specific testing on the Galaxy On Max is still required.
