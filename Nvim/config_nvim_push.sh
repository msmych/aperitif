#!/bin/bash

source_dir="$HOME/.config/nvim"
target_dir="$HOME/dev/aperitif/Nvim"

cp -r "$source_dir"/* "$target_dir"
