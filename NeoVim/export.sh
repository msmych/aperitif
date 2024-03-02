#!/bin/bash

source_dir="$HOME/.config/nvim"
target_dir="$APERITIF/Neovim/config"

rm -r "$target_dir"/*
cp -r "$source_dir"/* "$target_dir"

