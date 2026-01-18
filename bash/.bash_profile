#!/usr/bin/env bash

# Editor
EDITOR=$(command -v nvim)
export EDITOR

# Browser
BROWSER=$(command -v firefox)
export BROWSER

# Man pager
export MANPAGER="nvim +Man!"

# PKG config path
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH
export PKG_CONFIG_PATH=/usr/local/share/pkgconfig:$PKG_CONFIG_PATH

# LD Library path
export LD_LIBRARY_PATH=/usr/local/lib/:$LD_LIBRARY_PATH

# C compiler environment variables
if command -v clang > /dev/null;
then
    CC=$(command -v clang)
else
    CC=$(command -v gcc)
fi
export CC

# Path
export PATH="$HOME/.local/bin:$PATH"

# Source .bashrc on login (tmux triggers login)
source "$HOME/.bashrc"

# Start Sway on TTY login
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
    exec dbus-run-session sway
fi
