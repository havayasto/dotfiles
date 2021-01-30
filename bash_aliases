alias grep='grep --color=auto'
alias ll='ls -A --color=auto --group-directories-first'
alias ls='ls -CF --color=auto --group-directories-first'
alias e='exit'
alias c=clear
alias vi='nvim'
alias :e=vim
alias :qa=exit
alias :sp='test -n "$TMUX" && tmux split-window'
alias :vs='test -n "$TMUX" && tmux split-window -h'
alias :wq=exit
alias gh='history|grep'
alias count='find . -type f | wc -l'
alias cg='cd `git rev-parse --show-toplevel`'
