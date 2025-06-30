#!/usr/bin/env bash

# Basic environment variables
EDITOR=$(command -v nvim)
export EDITOR
BROWSER=$(command -v firefox)
export BROWSER

# C compiler environment variables
if command -v clang > /dev/null;
then
    CC=$(command -v clang)
else
    CC=$(command -v gcc)
fi
export CC

# Add to path
export PATH="$HOME/.local/bin:$PATH"

# Source .bashrc on login (tmux triggers login)
source "$HOME/.bashrc"

# Start Sway on TTY login
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
    exec dbus-run-session sway
fi

# FZF theme
export FZF_DEFAULT_OPTS="
--color=fg:#908caa,bg:#191724,hl:#ebbcba
--color=fg+:#e0def4,bg+:#26233a,hl+:#ebbcba
--color=border:#403d52,header:#31748f,gutter:#191724
--color=spinner:#f6c177,info:#9ccfd8
--color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa"

. "$HOME/.cargo/env"
