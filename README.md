# Dotfiles

This dotfiles have my installation instruction for Arch Linux and the 
configuration for my essential programs. The *master* branch contains a 
configuration for Arch linux, *ubuntu* for ubuntu OS and the *OSX* branch 
contains instruction to configure OSX programs such as mutt, offlineimap, pass.

I keep these dotfiles at `~/.dotfiles/` and I create softlinks to the dotfiles 
at `$HOME` using `create_links.sh`.

# Arch linux install 🐧

## Create partitions

Use fdisk or cdisk. UEFI configurations have 3 partitions (ESP in FAT32 512 Mb, / in ext4 , and swap of at least the RAM)

## Format partitions

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

* Set the root password:

```bash
# passwd
```

* Boot loader

For efi systems using grub.

> grub-mkconfig will automatically detect the microcode update and configure GRUB appropriately. After installing the intel-ucode package, users are directed to regenerate the GRUB config to activate loading the microcode 

```bash
pacman -S intel-ucode grub efibootmgr
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=arch
grub-mkconfig -o /boot/grub/grub.cfg
mkinitcpio -p linux
```

For not efi configurations look precedent commits

## Post installation instructions

Install minimum

```bash
pacman -S base-devel iw wpa_supplicant dialog sudo
```

## Video

### Xorg

1. Install packages

```bash
pacman -S xorg xorg-apps xorg-server xorg-server-utils xorg-xinit
```

2. Test using `startx`. If needed install `xterm` and `xorg-twm`

### Drivers

Install minimun drivers

```bash
pacman -S xf86-video xf86-video-intel
```

if nvidia graphic card, install `bumblebee mesa nvidia`

## Display manager

1. Install packages

```bash
pacman -S xorg-xdm
```

2. Enable service: `systemctl enable xdm.service`

## Windows manager - *i3*

```bash
pacman -S i3 dmenu
```

## Network manager

1. Install networkmanager packages

```bash
pacman -S networkmanager network-manager-applet
```

2. Enable service

```
systemctl enable NetworkManager
```

## Touchpad

1. Install libinput package

```bash
pacman -S xf86-input-libinput libinput
```

2. Create file `/etc/X11/xorg.conf.d/30-touchpad.conf` to configure touchpad

```
Section "InputClass"
    Identifier "touchpad"
    Driver "libinput"
    MatchIsTouchpad "on"
    Option "Tapping" "on"
    Option "TappingButtonMap" "lmr"
EndSection
```

3. Set X11 keyboard layout `localectl --no-convert set-x11-keymap fr`

## Disks management

Install diskie, if old keys use: `sudo pacman-key --refresh`

```bash
pacman -S udisks2 udiskie
```

## Additional

```bash
pacman -S tmux ranger mutt vim termite firefox xclip gnupg offlineimap pass 
notmuch notmuch-mutt msmtp atool dunst sxiv rsync zathura zathura-pdf-poppler 
zathura-djvu rofi inkscape gvfs feh libreoffice-still filezilla pavucontrol 
openssh w3m ctags arandr unclutter mpd highlight scrot curl git flake8 ruby 
nodejs npm mpd ncmpcpp mpc ntfs-3g
```

## Bluetooth

1. Install packages

```bash
pacman -S alsa-utils bluez bluez-utils blueman pulseaudio-bluetooth
```

2. Enable service

```
systemctl enable bluetooth.service
```

## Fonts

* Download popular fonts

```sh
pacman -S ttf-inconsolata awesome-terminal-fonts powerline-fonts noto-fonts-emoji
```

* Add [InconsolataGo nerd font](https://github.com/ryanoasis/nerd-fonts/releases)

```sh
curl -L https://github.com/ryanoasis/nerd-fonts/releases/download/v1.2.0/InconsolataGo.zip --output InconsolataGo.zip
extract InconsolataGo.zip
rm InconsolataGo.zip
mkdir /usr/share/fonts/InconsolataGo
mv InconsolataGo* /usr/share/fonts/InconsolataGo
chmod 0555 /usr/share/fonts/InconsolataGo
chmod 0444 /usr/share/fonts/InconsolataGo/InconsolataGo*
```

## Cower

```bash
gpg --recv-keys --keyserver hkp://pgp.mit.edu 1EB2638FF56C0C53
curl -o PKGBUILD https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=cower
makepkg -si PKGBUILD --noconfirm
```

* AUR: polybar

## Python

* Basic packages for Data Science

```bash
pacman -S jupyter mathjax python-numpy python-matplotlib python-pandas python-virtualenvwrapper
```

* Other

```sh
pip install -U mutt_ics urlscan
```
