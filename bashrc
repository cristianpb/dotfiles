#
# ~/.bashrc
#

#######################################################################
#                               General                               #
#######################################################################
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Load shell prompt line
source ~/.shell_prompt.sh

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

#########################
#  Set text editor vim  #
#########################
export EDITOR=nvim
alias vi='nvim'
alias vim='nvim'

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

############
#  Ranger  #
############
# Disable loading of global config
export RANGER_LOAD_DEFAULT_RC=FALSE

#########################
#  Virtual Env Wrapper  #
#########################
PATH="$HOME/.local/bin:$PATH"
alias python='python3'
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Devel
source $HOME/.local/bin/virtualenvwrapper.sh

# Source API tokens
#source ~/.dotfiles/APIs

# Use bash-completion, if available
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
    . /usr/share/bash-completion/bash_completion
