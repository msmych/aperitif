#!/bin/bash

source_dir="$APERITIF/Neovim/config"
target_dir="$HOME/.config/nvim"

rm -r "$target_dir"/*
cp -r "$source_dir"/* "$target_dir"
