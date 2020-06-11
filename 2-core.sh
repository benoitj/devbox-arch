#!/usr/bin/env bash

# install X LXDE and alsa utils
pacman -S --noconfirm xorg-server lxde xf86-video-vmware

# PulseAudio seems to remove crackling sound, YMMV
pacman -S --noconfirm alsa-utils pulseaudio pulseaudio-alsa

# now that we have X, swap vb guest utils with the one that support X
pacman -Rns --noconfirm virtualbox-guest-utils-nox
pacman -S --noconfirm virtualbox-guest-utils
systemctl enable vboxservice
systemctl start vboxservice

# packages needed if you want to compile guest additions from iso:
pacman -S --noconfirm which gcc make perl linux-headers vim

# install guest additions
mount /dev/sr0 /mnt && cd /mnt && ./VBoxLinuxAdditions.run -- --force
umount -f /mnt

# start lxdm at boot
systemctl enable lxdm
systemctl start lxdm

