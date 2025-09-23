#/usr/bin/bash

# Base cli tools
brew install neovim stow zoxide lsd luarocks fzf ripgrep git fd highlight htop gcc make lazygit

# Terminal
brew install --cask ghostty

# TMUX plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Apply stow
stow .
