#!/bin/bash

curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update
sudo apt install gh

set -u
echo "$ghtoken" > .githubtoken
unset ghtoken
gh auth login --with-token < .githubtoken
rm .githubtoken
cd ~
# check if repo is there
[ ! -d "OE2-Group-Project" ] && gh repo clone leggant/OE2-Group-Project
