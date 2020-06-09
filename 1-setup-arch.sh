#!/usr/bin/env bash

# localisation configuration eg. en_NZ Auckland
ln -sf /usr/share/zoneinfo/Pacific/Auckland /etc/localtime
mv /etc/locale.gen /etc/locale.gen.old
echo -e "en_NZ.UTF-8 UTF-8\nen_US.UTF-8 UTF-8" > /etc/locale.gen
echo "LANG=en_NZ.UTF-8" > /etc/locale.conf
locale-gen

# setup mirror
curl -s "https://www.archlinux.org/mirrorlist/?country=CA&protocol=https&use_mirror_status=on" | grep -e waterloo  | sed -e 's/^#Server/Server/' -e '/^#/d' > /etc/pacman.d/mirrorlist
curl -s "https://www.archlinux.org/mirrorlist/?country=CA&protocol=https&use_mirror_status=on" | grep -v waterloo  | sed -e 's/^#Server/Server/' -e '/^#/d' >> /etc/pacman.d/mirrorlist

# update os
pacman -Syyu --noconfirm --noprogressbar

