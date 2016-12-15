# Created by newuser for 5.2
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd beep extendedglob nomatch notify
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/arch/.zshrc'

autoload -Uz compinit
compinit
autoload -Uz promptinit
promptinit
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# End of lines added by compinstall

# Editor
export EDITOR=vim
alias vi='vim'

# Ranger alias
rg() {
    if [ -z "$RANGER_LEVEL" ]
    then
        ranger
    else
        exit
    fi
}

# Dictionary
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

# TMUX
# If not running interactively, do not do anything
[[ $- != *i* ]] && return
[[ -z "$TMUX" ]] && exec tmux

#SSH alias
alias enscp='ssh -X c.perez-brokate@193.51.253.15 -p 993'
#alias enscp='ssh c.perez-broka@193.51.253.222 -Y'
alias leri8='ssh -p 993 c.perez-brokate@193.51.253.15 -L 7777:10.0.1.122:22'
alias conssh='ssh -p 7777 cristian@127.0.0.1 -Y'

alias toshiba2pc='rsync -avzh --delete --progress /run/media/arch/Toshiba/UPMC /home/arch/Documents'
alias pc2toshiba='rsync -avzh --delete --progress /home/arch/Documents/UPMC /run/media/arch/Toshiba'
alias pc2toshibaMusic='rsync -avzh --delete --progress /home/arch/Music /run/media/arch/Toshiba'
alias pc2toshibaPictures='rsync -avzh --delete --progress /home/arch/Images/ /run/media/arch/Toshiba2/Pictures/'
alias toshiba2pcPapeles='rsync -avzh --delete --progress /run/media/arch/Toshiba2/Clases/Papeles /home/arch/Documents'
alias pc2toshibaPapeles='rsync -avzh --delete --progress /home/arch/Documents/Papeles/ /run/media/arch/Toshiba2/Clases/Papeles/'
alias pc2toshibaCV='rsync -avzh --delete --progress /home/arch/Documents/CVS/ /run/media/arch/Toshiba2/Clases/CVS/'
alias toshiba2pcCV='rsync -avzh --delete --progress /run/media/arch/Toshiba2/Clases/CVS/ /home/arch/Documents/CVS/'
alias pc2toshibaR='rsync -avzh --delete --progress /home/arch/R/examples/ /run/media/arch/Toshiba2/Clases/R/'
alias toshiba2pcR='rsync -avzh --delete --progress /run/media/arch/Toshiba2/Clases/R/ /home/arch/R/examples/'
alias pc2toshibaScript='rsync -avzh --delete --progress /home/arch/Documents/Script /run/media/arch/Toshiba2/Clases'
alias toshiba2pcScript='rsync -avzh --delete --progress /run/media/arch/Toshiba2/Clases/Script/ /home/arch/Documents/Script/'

alias pc2toshibaTotal='rsync -avzh --delete --progress /home/arch/Documents/ /run/media/arch/Toshiba2/Clases/'
alias toshiba2pcTotal='rsync -avzh --delete --progress /run/media/arch/Toshiba2/Clases/ /home/arch/Documents'
alias toshiba2pcMusic='rsync -avzh --delete --progress /run/media/arch/Toshiba/Music/ /home/arch/Musique/'
alias toshiba2pcPictures='rsync -avzh --delete --progress /run/media/arch/Toshiba2/Pictures/ /home/arch/Images/'

alias ddisk='udisksctl unmount -b /dev/sdc1;udisksctl unmount -b /dev/dm-0;udisksctl lock -b /dev/sdc2;udisksctl power-off -b /dev/sdc;'
