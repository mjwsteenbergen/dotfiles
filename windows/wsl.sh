#!/bin/bash

rm -r ~/.ssh
mkdir ~/.ssh
cp /mnt/c/Users/$USER/.ssh/* ~/.ssh -r
sudo chmod 600 ~/.ssh/*

# reconfigure timezone to correct one
sudo dpkg-reconfigure tzdata