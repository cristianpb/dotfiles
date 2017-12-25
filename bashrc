#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

PS1='[\u@\h \W]\$ '

#PS1='[\u@\h \W]\$ '  # To leave the default one
#DO NOT USE RAW ESCAPES, USE TPUT
reset=$(tput sgr0)
red=$(tput setaf 1)
blue=$(tput setaf 4)
green=$(tput setaf 2)

PS1='\[$red\]\u\[$reset\] \[$blue\]\W\[$reset\] \$ '
source ~/.shell_prompt.sh

function extract()      # Handy Extract Program
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

function def {
# espeak for the pronunciation audible output and phonetic alphabet string
#echo "Phoneme mnemonics: $(espeak -ven-uk-rp -x -s 120 "$1" 2> /dev/null)"       
# dict - the client for the dictionary server
sdcv --data-dir ~/Documents/Script/EnglishDic/ -n "$1" | less
}

function sig {
# espeak for the pronunciation audible output and phonetic alphabet string
#echo "Phoneme mnemonics: $(espeak -ven-uk-rp -x -s 120 "$1" 2> /dev/null)"       
# dict - the client for the dictionary server
sdcv --data-dir ~/Documents/Script/FrenchDic/ -n "$1" | less
}

function syn {
sdcv "$1" -u "Moby Thesaurus II"
}

function levantese() { sudo rtcwake -vm no -a -t $(date +%s -d "${1%%/}") ; }

#alias klab='ssh -p 2266 lab@hq.kernix.com'
alias klab='ssh -p 2266 -L 8899:localhost:8899 lab@hq.kernix.com'
function getklab() { scp -P 2266 -pr lab@hq.kernix.com:/Users/lab/Cristian/"${1%%/}" ./ ; }
function putklab() { scp -P 2266 -pr "${1%%/}" lab@hq.kernix.com:/Users/lab/Cristian/  ; }

alias toshiba2pc='rsync -avzh --delete --progress /run/media/cris/Toshiba/UPMC /home/cris/Documents'
alias pc2toshiba='rsync -avzh --delete --progress /home/cris/Documents/UPMC /run/media/cris/Toshiba'
alias pc2toshibaMusic='rsync -avzh --delete --progress /home/cris/Music /run/media/cris/Toshiba'
alias pc2toshibaPictures='rsync -avzh --delete --progress /home/cris/Images/ /run/media/cris/Toshiba2/Pictures/'
alias toshiba2pcPapeles='rsync -avzh --delete --progress /run/media/cris/Toshiba2/Clases/Papeles /home/cris/Documents'
alias pc2toshibaPapeles='rsync -avzh --delete --progress /home/cris/Documents/Papeles/ /run/media/cris/Toshiba2/Clases/Papeles/'
alias pc2toshibaCV='rsync -avzh --delete --progress /home/cris/Documents/CVS/ /run/media/cris/Toshiba2/Clases/CVS/'
alias toshiba2pcCV='rsync -avzh --delete --progress /run/media/cris/Toshiba2/Clases/CVS/ /home/cris/Documents/CVS/'
alias pc2toshibaR='rsync -avzh --delete --progress /home/cris/R/examples/ /run/media/cris/Toshiba2/Clases/R/'
alias toshiba2pcR='rsync -avzh --delete --progress /run/media/cris/Toshiba2/Clases/R/ /home/cris/R/examples/'
alias pc2toshibaScript='rsync -avzh --delete --progress /home/cris/Documents/Script /run/media/cris/Toshiba2/Clases'
alias toshiba2pcScript='rsync -avzh --delete --progress /run/media/cris/Toshiba2/Clases/Script/ /home/cris/Documents/Script/'

alias pc2toshibaTotal='rsync -avzh --delete --progress /home/cris/Documents/ /run/media/cris/Toshiba2/Clases/'
alias toshiba2pcTotal='rsync -avzh --delete --progress /run/media/cris/Toshiba2/Clases/ /home/cris/Documents'
alias toshiba2pcMusic='rsync -avzh --delete --progress /run/media/cris/Toshiba/Music/ /home/cris/Musique/'
alias toshiba2pcPictures='rsync -avzh --delete --progress /run/media/cris/Toshiba2/Pictures/ /home/cris/Images/'

export PATH=/opt/cuda/bin:$PATH
export LD_LIBRARY_PATH=/opt/cuda/lib64:$LD_LIBRARY_PATH

function cowerup() { cower -df "${1%%/}" ; cd ~/.builds/"${1%%/}" ; makepkg -si ; cd ~ ; }
alias manus='cd /home/cris/Documents/UPMC/Presentations/These/Manuscrit/'
alias vi='vim'
alias bbon='sudo tee /proc/acpi/bbswitch <<< ON'
alias bboff='sudo rmmod nvidia_uvm; sudo rmmod nvidia; sudo tee /proc/acpi/bbswitch <<< OFF;'
alias ncm='ncmpcpp'

alias ltx="grep -l '\\documentclass' *tex | xargs latexmk -pdf -pvc -silent > /dev/null 2>&1 &"


rg() {
    if [ -z "$RANGER_LEVEL" ]
    then
        ranger
    else
        exit
    fi
}


alias ddisk='udisksctl unmount -b /dev/sdc1;udisksctl unmount -b /dev/dm-0;udisksctl lock -b /dev/sdc2;udisksctl power-off -b /dev/sdc;'
alias udisk='udisksctl unlock -b /dev/sdc2;udisksctl mount -b /dev/dm-0;'
alias ledu='sudo ~/.config/i3/leds_up.sh' # keyboardlight
alias ledd='sudo ~/.config/i3/leds_down.sh' # keyboardlight

# If not running interactively, do not do anything
[[ $- != *i* ]] && return
[[ -z "$TMUX" ]] && exec tmux

# TMUX
if which tmux >/dev/null 2>&1; then
    #if not inside a tmux session, and if no session is started, start a new session
    test -z "$TMUX" && (tmux attach || tmux new-session)
fi

# Set editor  vim
export EDITOR=vim

# Export ruby gems
PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH"
# Install locally gems
export GEM_HOME=$(ruby -e 'print Gem.user_dir')

# GPG variables
GPG_TTY=$(tty)
export GPG_TTY

# Java for neo4j
#export JAVA_HOME=/usr/lib/jvm/java-8-openjdk
#export JAVA_HOME= /usr/lib/jvm/java-7-openjdk/jre

#CHROME_PATH="/usr/bin/google-chrome-unstable" node test_nick.js

# No mac
#. /etc/profile.d/vte.sh
#source ~/.dotfiles/APIs
alias top='htop'
alias ls='ls -G'
export PATH="/usr/local/sbin:$PATH"
export PATH="~/.bin:$PATH"


# Point perl to local modules
export PERL_LOCAL_LIB_ROOT="$HOME/perl5"
export PERL5LIB="$PERL_LOCAL_LIB_ROOT/lib/perl5"
export PERL_MB_OPT="--install_base \"$PERL_LOCAL_LIB_ROOT\""
export PERL_MM_OPT="INSTALL_BASE=$PERL_LOCAL_LIB_ROOT"
export PATH="$PERL_LOCAL_LIB_ROOT/bin:$PATH";
