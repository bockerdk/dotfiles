#!/usr/bin/env bash

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# PS1
PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# Alias
alias ls='ls --color=auto'
alias l='ls -l'
alias ll='ls -la'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

# Tmux launcher
alias t='tmux attach || txs'
