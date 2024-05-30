#!/bin/sh

# Step 1: Create a docker container
docker run --name=snippets -it ubuntu:20.04 /bin/bash
# exit
# docker start -ai snippets
# docker rm snippets

# Step 2: Set up Sudo
apt update -y;
apt install -y sudo;
rm -rf /var/lib/apt/lists/*;
passwd; # Manual step - Create a sudo password

# Step 3: Create the user
adduser snippets; # Manual Step - Password + Optional User Info 
usermod -a -G tty snippets
usermod -a -G sudo snippets;
su - snippets;

# Step 4: Install dependencies
sudo apt update -y; # Manual step - Enter sudo password
sudo apt install -y git neovim curl ripgrep;

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
. "$HOME/.nvm/nvm.sh" 

nvm install 18
nvm use 18
npm i -g typescript

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
bash ~/.fzf/install # Some manual options
source ~/.fzf.bash

# Install dotfiles
git clone https://github.com/JRasmusBm/dotfiles projects/dotfiles

cd projects/dotfiles
git switch -d 23f7b85e941e8a45b58630dea337abcd2e92650f

# Avoid having to authenticate
sed -i 's;git@github.com:;https://github.com/;' ./.gitmodules
git submodule sync --recursive
git submodule update --init --recursive
git submodule deinit -f vim/pack/python/start/vimpyter

# Install Dotfiles
mkdir -p .config/git
python3 scripts/symlink.py

cd ~/projects
nvim
