# Dotfiles

This dotfiles have my installation instruction for Arch Linux and the 
configuration for my essential programs. The *master* branch contains a 
configuration for Linux programs and the *OSX* branch contains instruction to 
configure OSX programs such as mutt, offlineimap, pass.

I keep these dotfiles at `~/.dotfiles/` and I create softlinks to the dotfiles 
at `$HOME` using `create_links.sh`.

# Arch linux install 🐧

* Create partitions
* Format partitions

```sh
# mkfs.ext4 /dev/sdaY
# mkswap /dev/sdaZ
```

* Mount system and swap

```sh
# swapon /dev/sdaZ
# mount /dev/sda1 /mnt
```

* Use the pacstrap script to install the base package group:

```bash
# pacstrap /mnt base
```

* Generate an fstab file (use -U or -L to define by UUID or labels, respectively):

```bash
# genfstab -U /mnt >> /mnt/etc/fstab
```

* Change root into the new system:

```bash
# arch-chroot /mnt
```

* Set the time zone:

```bash
# ln -sf /usr/share/zoneinfo/Region/City /etc/localtime
```

* Run hwclock(8) to generate /etc/adjtime:

```bash
# hwclock --systohc
```

* Uncomment en_US.UTF-8 UTF-8 and other needed localizations in /etc/locale.gen, and generate them with:

```bash
# locale-gen
```

* Set the LANG variable in `/etc/locale.conf`

```bash
LANG=en_US.UTF-8
```

* If you set the keyboard layout, make the changes persistent in vconsole `/etc/vconsole.conf`

```bash
KEYMAP=fr-latin1
```

* Create the hostname in `/etc/hostname`

```bash
myhostname
```

* Consider adding a matching entry to hosts `/etc/hosts`

```bash
127.0.0.1	localhost.localdomain	localhost
::1		localhost.localdomain	localhost
127.0.1.1	myhostname.localdomain	myhostname
```

* Optionally install dialog for usage of wifi-menu.

```bash
# pacman -S dialog
```

* Set the root password:

```bash
# passwd
```

* Boot loader: Grub

```bash
# pacman -S grub
# grub-install --target=i386-pc /dev/sdx
# grub-mkconfig -o /boot/grub/grub.cfg
```

where /dev/sdx is the partitioned disk where grub is to be installed. 

## Post installation instructions

```bash
pacman -S base base-devel iw wpa_supplicant intel-ucode grub dialog sudo
```

## Video

### Xorg

```bash
pacman -S xorg xorg-apps xorg-server xorg-server-utils xorg-xinit xorg-xinit
```

### Drivers

```bash
pacman -S xf86-video bumblebee mesa nvidia xf86-video-intel
```

## Display manager

```bash
pacman -S xorg-xdm
```

Enable the display manager service: `# systemctl enable xdm.service`

## Windows manager - *i3*

```bash
pacman -S i3 dmenu
```

## Network manager

```bash
pacman -S networkmanager network-manager-applet
```

## Touchpad

```bash
pacman -S xf86-input-libinput libinput
```

## Disks management

```bash
pacman -S udisks2 udiskie
```

## Additional

```bash
pacman -S tmux ranger mutt vim termite firefox xclip gnupg offlineimap pass 
notmuch notmuch-mutt msmtp atool dunst sxiv rsync zathura zathura-pdf-poppler 
zathura-djvu rofi inkscape gvfs feh libreoffice-still filezilla pavucontrol 
openssh w3m ctags arandr unclutter mpd
```

## Bluetooth

```bash
pacman -S alsa-utils bluez bluez-utils blueman pulseaudio-bluetooth
```

## Fonts

* Download popular fonts

```sh
pacman -S ttf-inconsolata awesome-terminal-fonts powerline-fonts noto-fonts-emoji
```

* Add [InconsolataGo nerd font](https://github.com/ryanoasis/nerd-fonts/releases)

```sh
curl https://github.com/ryanoasis/nerd-fonts/releases/download/v1.2.0/InconsolataGo.zip --output InconsolataGo.zip
mkdir /usr/share/fonts/InconsolataGo
mv InconsolataGo.zip /usr/share/fonts/InconsolataGo
extract /usr/share/fonts/InconsolataGo/InconsolataGo.zip
chmod 0555 /usr/share/fonts/InconsolataGo
chmod 0444 /usr/share/fonts/InconsolataGo/InconsolataGo.zip
```

## Cower

```bash
# gpg --recv-keys --keyserver hkp://pgp.mit.edu 1EB2638FF56C0C53
# curl -o PKGBUILD https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=cower
# makepkg -si PKGBUILD --noconfirm
```

* AUR: polybar

## Python

* Basic packages for Data Science

```bash
pacman -S jupyter mathjax python-numpy python-matplotlib python-pandas
```

* Other

```sh
pip install -U mutt_ics urlscan
```
