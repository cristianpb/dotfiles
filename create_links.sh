#!/bin/bash

# https://github.com/kaicataldo/dotfiles/blob/master/bin/install.sh

# This symlinks all the dotfiles (and .atom/) to ~/
# It also symlinks ~/bin for easy updating

# This is safe to run multiple times and will prompt you about anything unclear


###########
#  Utils  #
###########

answer_is_yes() {
  [[ "$REPLY" =~ ^[Yy]$ ]] \
    && return 0 \
    || return 1
}

ask() {
  print_question "$1"
  read
}

ask_for_confirmation() {
  print_question "$1 (y/n) "
  read -n 1
  printf "\n"
}

ask_for_sudo() {

  # Ask for the administrator password upfront
  sudo -v

  # Update existing `sudo` time stamp until this script has finished
  # https://gist.github.com/cowboy/3118588
  while true; do
    sudo -n true
    sleep 60
    kill -0 "$$" || exit
  done &> /dev/null &

}

cmd_exists() {
  [ -x "$(command -v "$1")" ] \
    && printf 0 \
    || printf 1
}

execute() {
  $1 &> /dev/null
  print_result $? "${2:-$1}"
}

get_answer() {
  printf "$REPLY"
}

get_os() {

  declare -r OS_NAME="$(uname -s)"
  local os=""

  if [ "$OS_NAME" == "Darwin" ]; then
    os="osx"
  elif [ "$OS_NAME" == "Linux" ] && [ -e "/etc/lsb-release" ]; then
    os="ubuntu"
  fi

  printf "%s" "$os"

}

is_git_repository() {
  [ "$(git rev-parse &>/dev/null; printf $?)" -eq 0 ] \
    && return 0 \
    || return 1
}

mkd() {
  if [ -n "$1" ]; then
    if [ -e "$1" ]; then
      if [ ! -d "$1" ]; then
        print_error "$1 - a file with the same name already exists!"
      else
        print_success "$1"
      fi
    else
      execute "mkdir -p $1" "$1"
    fi
  fi
}

print_error() {
  # Print output in red
  printf "\e[0;31m  [✖] $1 $2\e[0m\n"
}

print_info() {
  # Print output in purple
  printf "\n\e[0;35m $1\e[0m\n\n"
}

print_question() {
  # Print output in yellow
  printf "\e[0;33m  [?] $1\e[0m"
}

print_result() {
  [ $1 -eq 0 ] \
    && print_success "$2" \
    || print_error "$2"

  [ "$3" == "true" ] && [ $1 -ne 0 ] \
    && exit
}

print_success() {
  # Print output in green
  printf "\e[0;32m  [✔] $1\e[0m\n"
}

#########
#  Dir  #
#########


dir=~/.dotfiles                        # dotfiles directory
dir_backup=/tmp/dotfiles_old             # old dotfiles backup directory

# Get current dir (so run this script from anywhere)

#DOTFILES_DIR="$(dirname "$SCRIPT_DIR")"
#export DOTFILES_DIR
#DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Create dotfiles_old in homedir
echo -n "Creating $dir_backup for backup of any existing dotfiles in ~..."
mkdir -p $dir_backup
echo "done"

# Change to the dotfiles directory
echo -n "Changing to the $dir directory..."
cd $dir
echo "done"

declare -a FILES_TO_SYMLINK=(
    'toprc'
    'bashrc'
    'bash_profile'
    'BingDownloadImage.sh'
    'checkmail.sh'
    'create_links.sh'
    'editorconfig'
    'gitconfig'
    'msmtprc'
    'new_mail.sh'
    'notmuch-hook.sh'
    'Rprofile'
    'shell_prompt.sh'
    'tmux.conf'
    'tmux.theme'
    'toprc'
    'vimrc'
    'xinitrc'
    'Xresources'
)

# FILES_TO_SYMLINK="$FILES_TO_SYMLINK .vim bin" # add in vim and the binaries

# Move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks from the homedir to any files in the ~/dotfiles directory specified in $files

for i in ${FILES_TO_SYMLINK[@]}; do
  echo "Moving any existing dotfiles from ~ to $dir_backup"
  mv ~/.${i##*/} ~/dotfiles_old/
done

for i in ${FILES_TO_SYMLINK[@]}; do
    sourceFile="$(pwd)/$i"
    targetFile="$HOME/.$(printf "%s" "$i" | sed "s/.*\/\(.*\)/\1/g")"
    if [ ! -e "$targetFile" ]; then
        execute "ln -fs $sourceFile $targetFile" "$targetFile → $sourceFile"
    elif [ "$(readlink "$targetFile")" == "$sourceFile" ]; then
        print_success "$targetFile → $sourceFile"
    else
        ask_for_confirmation "'$targetFile' already exists, do you want to overwrite it?"
        if answer_is_yes; then
            rm -rf "$targetFile"
            execute "ln -fs $sourceFile $targetFile" "$targetFile → $sourceFile"
        else
            print_error "$targetFile → $sourceFile"
        fi
    fi
done

#####################
#  Folders to root  #
#####################


declare -a FILES_TO_SYMLINK=(
    'mutt/mutt'
    'mutt/muttrc'
    'mutt/gpg.rc'
    'offlineimap/offlineimaprc'
    'offlineimap/offlineimap2.py'
    'zsh/zshrc'
    'zsh/zshenv'
    'mpd/mpd'
    'mpd/mpdconf'
    'ncmpcpp/ncmpcpp'
)

# FILES_TO_SYMLINK="$FILES_TO_SYMLINK .vim bin" # add in vim and the binaries

# Move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks from the homedir to any files in the ~/dotfiles directory specified in $files

for i in ${FILES_TO_SYMLINK[@]}; do
  echo "Moving any existing dotfiles from ~ to $dir_backup"
  mv ~/.${i##*/} ~/dotfiles_old/
done

for i in ${FILES_TO_SYMLINK[@]}; do
    sourceFile="$(pwd)/tag-$i"
    targetFile="$HOME/.$(printf "%s" "$i" | sed "s/.*\/\(.*\)/\1/g")"
    if [ ! -e "$targetFile" ]; then
        execute "ln -fs $sourceFile $targetFile" "$targetFile → $sourceFile"
    elif [ "$(readlink "$targetFile")" == "$sourceFile" ]; then
        print_success "$targetFile → $sourceFile"
    else
        ask_for_confirmation "'$targetFile' already exists, do you want to overwrite it?"
        if answer_is_yes; then
            rm -rf "$targetFile"
            execute "ln -fs $sourceFile $targetFile" "$targetFile → $sourceFile"
        else
            print_error "$targetFile → $sourceFile"
        fi
    fi
done

######################
#  Folder to config  #
######################


declare -a FILES_TO_SYMLINK=(
    'polybar'
    'dunst'
    'ranger'
    'i3'
    'termite'
)

# FILES_TO_SYMLINK="$FILES_TO_SYMLINK .vim bin" # add in vim and the binaries

# Move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks from the homedir to any files in the ~/dotfiles directory specified in $files

for i in ${FILES_TO_SYMLINK[@]}; do
  echo "Moving any existing dotfiles from ~ to $dir_backup"
  mv ~/.${i##*/} ~/dotfiles_old/
done

for i in ${FILES_TO_SYMLINK[@]}; do
    sourceFile="$(pwd)/tag-$i/config/$i"
    targetFile="$HOME/.config/$(printf "%s" "$i" | sed "s/.*\/\(.*\)/\1/g")"
    if [ ! -e "$targetFile" ]; then
        execute "ln -fs $sourceFile $targetFile" "$targetFile → $sourceFile"
    elif [ "$(readlink "$targetFile")" == "$sourceFile" ]; then
        print_success "$targetFile → $sourceFile"
    else
        ask_for_confirmation "'$targetFile' already exists, do you want to overwrite it?"
        if answer_is_yes; then
            rm -rf "$targetFile"
            execute "ln -fs $sourceFile $targetFile" "$targetFile → $sourceFile"
        else
            print_error "$targetFile → $sourceFile"
        fi
    fi
done
