#!/bin/bash 

# Make Symlinks
stow -R zsh tmux git alacritty nvim karabiner bat fonts 

# Clear Font Cache
# fc-cache -f -v

# Build Bat Theme Cache
bat cache --build
