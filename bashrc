# ~/.bashrc: executed by bash(1) for non-login shells.

# if not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=
HISTFILESIZE=

# vi mode in bash
set -o vi
bind 'set show-mode-in-prompt on'

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# if this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# alias definitions.
# you may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# adds the current branch to the bash prompt when the working directory is
# part of a Git repository. includes color-coding and indicators to quickly
# indicate the status of working directory.
# based upon the following gists:
# <https://gist.github.com/henrik/31631>
# <https://gist.github.com/srguiwiz/de87bf6355717f0eede5>
# modified by me, using ideas from comments on those gists.

git_branch() {
    # -- finds and outputs the current branch name by parsing the list of
    #    all branches
    # -- current branch is identified by an asterisk at the beginning
    # -- if not in a Git repository, error message goes to /dev/null and
    #    no output is produced
    git branch --no-color 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

git_status() {
    # outputs a series of indicators based on the status of the
    # working directory:
    # + changes are staged and ready to commit
    # ! unstaged changes are present
    # ? untracked files are present
    # S changes have been stashed
    # P local commits need to be pushed to the remote
    local status="$(git status --porcelain 2>/dev/null)"
    local output=''
    [[ -n $(egrep '^[MADRC]' <<<"$status") ]] && output="$output+"
    [[ -n $(egrep '^.[MD]' <<<"$status") ]] && output="$output!"
    [[ -n $(egrep '^\?\?' <<<"$status") ]] && output="$output?"
    [[ -n $(git stash list) ]] && output="${output}S"
    [[ -n $(git log --branches --not --remotes) ]] && output="${output}P"
    [[ -n $output ]] && output="|$output"  # separate from branch name
    echo $output
}

git_color() {
    # receives output of git_status as argument; produces appropriate color
    # code based on status of working directory:
    # - white if everything is clean
    # - green if all changes are staged
    # - red if there are uncommitted changes with nothing staged
    # - yellow if there are both staged and unstaged changes
    # - blue if there are unpushed commits
    local staged=$([[ $1 =~ \+ ]] && echo yes)
    local dirty=$([[ $1 =~ [!\?] ]] && echo yes)
    local needs_push=$([[ $1 =~ P ]] && echo yes)
    if [[ -n $staged ]] && [[ -n $dirty ]]; then
        echo -e '\033[0;33m ●''\033[0;31m ●'  # bold yellow
    elif [[ -n $staged ]]; then
        echo -e '\033[0;32m ●'  # bold green
    elif [[ -n $dirty ]]; then
        echo -e '\033[0;31m ●'  # bold red
    elif [[ -n $needs_push ]]; then
        echo -e '\033[0;34m ●' # bold blue
    else
		echo -e '\033[1;37m ●'  # bold white
    fi
}

# TODO: check the colors if remote git repo is updated

git_prompt() {
    # first, get the branch name...
    local branch=$(git_branch)
    # empty output? Then we're not in a git repository, so bypass the rest
    # of the function, producing no output
    if [[ -n $branch ]]; then
        local state=$(git_status)
        local color=$(git_color $state)
        # now output the actual code to insert the branch and status
	#echo -e "\x01$color\x02[$branch$state]\x01\033[00m\x02" 
        echo -e "\x01$color"  # last bit resets color
    fi
}

# sample prompt declaration. tweak as you see fit, or just stick
# "$(git_prompt)" into your favorite prompt.

# TODO; fix the vi modes bug

PS1='$(git_prompt) \[\e[0m\](\[\e[0;1;91m\]\W\[\e[0m\])\[\e[m\] \[\e0'
