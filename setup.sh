#!/bin/sh
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

# pick fastest package mirrors
pacman -S pacman-contrib
# cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
# awk '/^## United States$/{f=1}f==0{next}/^$/{exit}{print substr($0, 2)}' /etc/pacman.d/mirrorlist.backup
# rankmirrors -n 6 /etc/pacman.d/mirrorlist.backup > /etc/pacman.d/mirrorlist
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
cp $DIR/mirrorlist /etc/pacman.d/mirrorlist

# useful initial packages
pacman -S base-devel connman dialog git wpa_supplicant zsh

# user setup
useradd --create-home ellioth
passwd ellioth
chsh ellioth -s /bin/zsh

visudo # add this line: ellioth ALL=(ALL) ALL

systemctl enable connman
systemctl start connman

# install packages
./$DIR/install-pacman.sh $DIR/core/pacman-packages.txt 

# AUR package manager
mkdir $HOME/build
cd $HOME/build
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si


./$DIR/install-yay.sh $DIR/core/aur-packages.txt 

# set up yubikey https://support.yubico.com/support/solutions/articles/15000006449-using-your-u2f-yubikey-with-linux
curl https://raw.githubusercontent.com/Yubico/libu2f-host/master/70-u2f.rules > /etc/udev/rules.d/70-u2f.rules

# enable services
# ntp
systemctl enable systemd-timesyncd
# login
systemctl enable gdm
# firewall
systemctl enable nftables
# printer
systemctl enable org.cups.cupsd.service
# systemctl enable dropbox@ellioth
# syncthing
systemctl enable syncthing@ellioth
