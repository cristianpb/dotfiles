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

# TMUX
if which tmux >/dev/null 2>&1; then
    #if not inside a tmux session, and if no session is started, start a new session
    test -z "$TMUX" && (tmux attach || tmux new-session)
fi

#SSH alias
alias enscp='ssh -X c.perez-brokate@193.51.253.15 -p 993'
#alias enscp='ssh c.perez-broka@193.51.253.222 -Y'
alias leri8='ssh -p 993 c.perez-brokate@193.51.253.15 -L 7777:10.0.1.122:22'
alias conssh='ssh -p 7777 cristian@127.0.0.1 -Y'
