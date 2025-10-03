#!/bin/bash
# Assuming install of zsh, install other prerequisites.
sudo apt-get update && apt-get install -y curl git

# Instal oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

