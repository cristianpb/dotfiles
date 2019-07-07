#
# ~/.bashrc
#

#######################################################################
#                               General                               #
#######################################################################
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Handy Extract Program
function extract()      
{
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1     ;;
            *.tar.gz)    tar xvzf $1     ;;
            *.bz2)       bunzip2 $1      ;;
            *.rar)       unrar x $1      ;;
            *.gz)        gunzip $1       ;;
            *.tar)       tar xvf $1      ;;
            *.tbz2)      tar xvjf $1     ;;
            *.tgz)       tar xvzf $1     ;;
            *.zip)       unzip $1        ;;
            *.Z)         uncompress $1   ;;
            *.7z)        7z x $1         ;;
            *)           echo "'$1' cannot be extracted via >extract<" ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}

# Creates an archive (*.tar.gz) from given directory.
function maketar() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }

# Create a ZIP archive of a file or folder.
function makezip() { zip -r "${1%%/}.zip" "$1" ; }

# Engligh dictionary definition (dict - the client for the dictionary server)
function def { sdcv --data-dir ~/Documents/Script/EnglishDic/ -n "$1" | less; }

# English thesaurus
function syn { sdcv "$1" --data-dir ~/Documents/Script/EnglishDic/ -u "Moby Thesaurus II"; }

# French dictionary definition
function sig { sdcv --data-dir ~/Documents/Script/FrenchDic/ -n "$1" | less; }

# Wakeup function
function levantese() { sudo rtcwake -vm no -a -t $(date +%s -d "${1%%/}") ; }

# Ranger shortcut to avoid open several ranger instances
rg() {
    if [ -z "$RANGER_LEVEL" ]
    then
        ranger
    else
        exit
    fi
}

#######################################################################
#                               Aliases                               #
#######################################################################
# ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ls='ls --color'

# Backup aliases
alias pc2toshibaDocuments='sudo rsync -e "sudo -u cris" -avzh --progress /home/arch/Documents/ /run/media/arch/Toshiba2/Documents'
alias pc2toshibaMusic='sudo rsync -e "sudo -u arch" -avzh --delete --progress /home/arch/Music_clean/ /run/media/arch/Toshiba/Music_clean/'
alias pc2toshibaPictures='sudo rsync -e "sudo -u arch" -avzh --progress /home/arch/Images/ /run/media/arch/Toshiba2/Pictures/'
alias pc2toshibaMail='sudo rsync -e "sudo -u arch" -avzh --progress /home/arch/.mail/ /run/media/arch/Toshiba2/Mail/'
alias pc2toshibaVideos='sudo rsync -e "sudo -u cris" -avzh --progress /home/cris/Videos/ /run/media/cris/Toshiba2/Videos/'
alias toshiba2pcDocuments='rsync -avzh --delete --progress /run/media/cris/Toshiba2/Clases/ /home/cris/Documents/'
alias toshiba2pcMusic='sudo rsync -e "sudo -u arch" -avzh --progress /run/media/arch/Toshiba/Music/ /home/arch/Music/'
alias toshiba2pcPictures='rsync -avzh --delete --progress /run/media/cris/Toshiba2/Pictures/ /home/cris/Images/'
# sudo rsync -e "sudo -u arch" -avzh --progress /run/media/arch/Toshiba2/Clases/Papeles /home/arch/Documents/

#######################################################################
#                              Shortcuts                              #
#######################################################################

# Install cower aur packages
function cowerup() { cower -df "${1%%/}" ; cd ~/.builds/"${1%%/}" ; makepkg -si; cd ~ ; }

# Turn on nvidia card
alias bbon='sudo tee /proc/acpi/bbswitch <<< ON'

# Turn off nvidia card
alias bboff='sudo rmmod nvidia_uvm; sudo rmmod nvidia; sudo tee /proc/acpi/bbswitch <<< OFF;'

# Music suite ncmpcpp
alias ncm='ncmpcpp'

# Compile latex on background
alias ltx="grep -l '\\documentclass' *tex | xargs latexmk -pdf -pvc -silent > /dev/null 2>&1 &"

# Unmount disk 
alias udisk='udisksctl unmount -b /dev/sdb1;udisksctl unmount -b /dev/dm-0;udisksctl lock -b /dev/sdb2;udisksctl power-off -b /dev/sdb;'

# Mount disk
alias mdisk='udisksctl unlock -b /dev/sdb2;udisksctl mount -b /dev/dm-0;'

# Keyboard light up
alias ledu='sudo ~/.config/i3/leds_up.sh' 

# Keyboard light down
alias ledd='sudo ~/.config/i3/leds_down.sh' 

#######################################################################
#                               Config                                #
#######################################################################
#########################
#  Set text editor vim  #
#########################
export EDITOR=nvim
alias vi='nvim'
alias vim='nvim'

######################
#  Add CUDA to path  #
######################
export PATH=/opt/cuda/bin:$PATH
export LD_LIBRARY_PATH=/opt/cuda/lib64:$LD_LIBRARY_PATH

##########
#  Ruby  #
##########
# Export ruby gems
PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH"

# Install locally gems
export GEM_HOME=$(ruby -e 'print Gem.user_dir')

###############
#  gpg-agent  #
###############
# GPG variables
GPG_TTY=$(tty)
export GPG_TTY

#############
#  Termite  #
#############
if [[ $TERM == xterm-termite ]]; then
  . /etc/profile.d/vte.sh
  __vte_prompt_command
fi

# Termite change conf
alias tdark='cp ~/.config/termite/configSolarizedDark ~/.config/termite/config' 
alias tlight='cp ~/.config/termite/configSolarizedLight ~/.config/termite/config'
alias tgruv='cp ~/.config/termite/configGruv ~/.config/termite/config' 

# Compatibility for ssh connection
export TERM=xterm-256color 

############
#  Ranger  #
############
# Disable loading of global config
export RANGER_LOAD_DEFAULT_RC=FALSE

#########################
#  Virtual Env Wrapper  #
#########################
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Devel
source /usr/bin/virtualenvwrapper.sh

############
#  Others  #
############
# Source API tokens
source ~/.dotfiles/APIs

alias milab='~/go/bin/slack-term -token "$SLACK_MILAB_TOKEN"'
alias eig='~/go/bin/slack-term -token "$SLACK_EIG_TOKEN"'
alias graf='grafana-server --config=/home/arch/.config/grafana/grafana.ini --homepath=/usr/share/grafana'

export PATH=/home/arch/.local/bin:$PATH
# Nicky for chrome
#CHROME_PATH="/usr/bin/google-chrome-unstable" node test_nick.js

# Use bash-completion, if available
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
    . /usr/share/bash-completion/bash_completion

# Load shell prompt line
source ~/.shell_prompt.sh

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
