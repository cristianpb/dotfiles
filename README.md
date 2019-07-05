# Dotfiles

This dotfiles have my installation instruction for Arch Linux and the configuration for my essential programs. The `master` branch contains a configuration for Arch linux, `ubuntu` for ubuntu OS and the `OSX` branch contains instruction to configure OSX programs such as mutt, mbsync, pass.

![dofiles](http://dotshare.it/public/images/uploads/8372.png)
![dofiles](http://dotshare.it/public/images/uploads/8287.png)
![dofiles](http://dotshare.it/public/images/uploads/8371.png)

## Install

Fetch dotfiles from github:

```
git clone https://github.com/cristianpb/dotfiles ~/.dotfiles
cd ~/.dotfiles || exit
```

Manually install files:

```
stow vim
```

Automatic install:

```
for d in $(ls -d */ | cut -f1 -d '/');
do
    ( stow "$d"  )
done
```
