# Assuming install of zsh, install other prerequisites.
sudo apt update -y
sudo apt install wget git -y

# Instal oh-my-zsh
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
