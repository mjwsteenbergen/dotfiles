#!/bin/bash

rm -r ~/.ssh
mkdir ~/.ssh
cp /mnt/c/Users/martijn/.ssh/* ~/.ssh -r
sudo chmod 600 ~/.ssh/*