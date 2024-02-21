#!/bin/bash

source_dir="$HOME/dev/aperitif/Nvim"
target_dir="$HOME/.config/nvim"

cp -r "$source_dir"/* "$target_dir"
