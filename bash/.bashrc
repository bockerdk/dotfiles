#!/usr/bin/env bash

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# PS1
PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# Alias
alias ls='ls --color=auto'
alias l='ls'
alias ll='ls -l'
alias lll='ls -la'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

# Tmux launcher
alias t='tmux attach || tmux new-session -s home -c $HOME'

# FZF colors
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS"'
--color=fg:#000000,fg+:#000000,bg:#FFFFFF,bg+:#F3F3F3
--color=hl:#008000,hl+:#AF00DB,info:#AF00DB,marker:#AF00DB
--color=prompt:#AF00DB,spinner:#AF00DB,pointer:#AF00DB,header:#008000
--color=border:#000000,label:#AF00DB,query:#000000'
