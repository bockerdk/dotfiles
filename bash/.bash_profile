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
