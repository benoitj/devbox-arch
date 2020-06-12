#!/usr/bin/env bash

# install X LXDE and alsa utils
pacman -S --noconfirm xorg-server openbox xf86-video-vmware lightdm lightdm-gtk-greeter rxvt-unicode

# PulseAudio seems to remove crackling sound, YMMV
pacman -S --noconfirm alsa-utils pulseaudio pulseaudio-alsa

# now that we have X, swap vb guest utils with the one that support X
pacman -Rns --noconfirm virtualbox-guest-utils-nox
pacman -S --noconfirm virtualbox-guest-utils
systemctl enable vboxservice
systemctl start vboxservice

# packages needed if you want to compile guest additions from iso:
pacman -S --noconfirm which gcc make perl linux-headers vim git fakeroot

# install guest additions
mount /dev/sr0 /mnt && cd /mnt && ./VBoxLinuxAdditions.run -- --force
umount -f /mnt

cd /tmp && sudo -u vagrant git clone https://aur.archlinux.org/xinit-xsession.git && cd xinit-xsession && sudo -u vagrant git checkout 7cae213844b && sudo -u vagrant makepkg -sic --noconfirm


cat <<EOT > ~vagrant/.xinitrc
#!/bin/bash
exec /usr/bin/openbox
EOT

chown vagrant:vagrant ~vagrant/.xinitrc
chmod +x ~vagrant/.xinitrc


# setup autologin
groupadd -r autologin
usermod -a -G autologin vagrant
sed -i -e 's/# *autologin-user=.*/autologin-user=vagrant/' /etc/lightdm/lightdm.conf
sed -i -e 's/# *autologin-session=.*/autologin-session=xinitrc/' /etc/lightdm/lightdm.conf

# start lxdm at boot
systemctl enable lightdm
systemctl start lightdm

