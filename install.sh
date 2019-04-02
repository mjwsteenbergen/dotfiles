#!/bin/bash

#Install
sudo apt-get install zsh htop curl zip

chsh -s $(which zsh)

# Install oh my zsh
export ZSH="$HOME/.oh-my-zsh"; sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Linking all files
function link {
	rm $2
	ln -s $1 $2
}


link ~/.dotfiles/.zshrc ~/.zshrc
link ~/.dotfiles/.bashrc ~/.bashrc
link ~/.dotfiles/.nanorc ~/.nanorc
link ~/.dotfiles/.dir_colors ~/.dir_colors
link ~/.dotfiles/.gitconfig ~/.gitconfig
sudo ln -s ~/.dotfiles/doi2bib.sh /usr/local/bin/doi2bib

git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/plugins/zsh-autosuggestions
git clone https://github.com/zdharma/fast-syntax-highlighting.git $HOME/.oh-my-zsh/plugins/fast-syntax-highlighting
git clone https://github.com/lukechilds/zsh-better-npm-completion $HOME/.oh-my-zsh/custom/plugins/zsh-better-npm-completion
git clone https://github.com/djui/alias-tips.git $HOME/.oh-my-zsh/custom/plugins/alias-tips
sudo chmod -R 755 $HOME/.oh-my-zsh/custom/plugins/