#!/bin/zsh

for file in ../* 
do 
    echo $file; 
    cd $file
    git fetch
    git status
    read
done