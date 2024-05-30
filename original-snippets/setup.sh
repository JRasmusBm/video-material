#!/bin/sh

docker run --name=snippets -it ubuntu:20.04 /bin/bash
# exit
# docker start -ai snippets
# docker rm snippets

apt update -y;
apt install -y sudo;
rm -rf /var/lib/apt/lists/*;
passwd; # Create a sudo password

adduser snippets; # Create a user
usermod -a -G tty snippets
usermod -a -G sudo snippets;
su - snippets; # Enter the user password you made

sudo apt update -y;
sudo apt install -y git neovim curl ripgrep;

mkdir -p .config/git

# rm -rf projects/dotfiles
git clone https://github.com/JRasmusBm/dotfiles projects/dotfiles

cd projects/dotfiles
git switch -d 23f7b85e941e8a45b58630dea337abcd2e92650f

# Avoid having to authenticate
sed -i 's;git@github.com:;https://github.com/;' ./.gitmodules
git submodule sync --recursive
git submodule update --init --recursive
git submodule deinit -f vim/pack/python/start/vimpyter

# Install Dotfiles
python3 scripts/symlink.py

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" 

nvm install 18
nvm use 18
npm i -g typescript

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
source ~/.fzf.bash

cd ~/projects
