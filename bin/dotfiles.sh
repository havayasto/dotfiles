#!/bin/sh

set -e

SESNAME=dotfiles
SESPATH=$HOME/repos/dotfiles

cd $SESPATH

SESLASTEDIT=$(find . -type f -printf '%T@ %P\n' | sort -n | awk '{print $2}' | tail -1)

if tmux has-session -t=$SESNAME 2> /dev/null; then
  tmux attach -t $SESNAME
  exit
fi

tmux new-session -d -s $SESNAME -n vim -x $(tput cols) -y $(tput lines)

tmux split-window -t $SESNAME:vim -h

tmux send-keys -t $SESNAME:vim.left "nvim $SESLASTEDIT -c CommandT" Enter
tmux send-keys -t $SESNAME:vim.right "git status" Enter

tmux new-window -t $SESNAME:2 -n 'diff'
tmux send-keys -t 'diff' 'git diff HEAD' C-m

tmux attach -t $SESNAME:vim.left
