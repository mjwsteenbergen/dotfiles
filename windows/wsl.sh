#!/bin/bash

function link {
	rm $2
	ln -s $1 $2
}

link /mnt/c/Users/$USER/Coding/ ~/coding
link /mnt/c/Users/$USER/Coding/.dotfiles/ ~/.dotfiles

sudo rm -r ~/.ssh
mkdir ~/.ssh
cp /mnt/c/Users/$USER/.ssh/* ~/.ssh -r
rm ~/.ssh/config
cp --dereference ~/.dotfiles/ssh-config ~/.ssh/config

sudo chmod -R 600 ~/.ssh/*

# reconfigure timezone to correct one
sudo dpkg-reconfigure tzdata