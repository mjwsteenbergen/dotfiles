#!/bin/bash

function link {
	[[ -e $2 ]] && rm $2
	ln -s $1 $2
}

install-linux-packages() {
	echo "# Install Linux Packages"
	sudo apt-get update
	sudo apt-get upgrade
	sudo apt-get install zsh htop curl zip

	# install micro
	curl https://getmic.ro | bash
}

install-diff-so-fancy() {
	echo '# Installing diff-so-fancy'
	wget https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy
	chmod +x diff-so-fancy
	sudo mv diff-so-fancy /usr/local/bin
}

setup-zsh() {
	chsh -s $(which zsh)
	# Install oh my zsh
	export ZSH="$HOME/.oh-my-zsh"; sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

	setup-zsh-packages() {
		echo "# Installing ZSH Plugins"
		git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/plugins/zsh-autosuggestions
		git clone https://github.com/zdharma/fast-syntax-highlighting.git $HOME/.oh-my-zsh/plugins/fast-syntax-highlighting
		git clone https://github.com/lukechilds/zsh-better-npm-completion $HOME/.oh-my-zsh/custom/plugins/zsh-better-npm-completion
		git clone https://github.com/djui/alias-tips.git $HOME/.oh-my-zsh/custom/plugins/alias-tips
		sudo chmod -R 755 $HOME/.oh-my-zsh/custom/plugins/
	}
	
	setup-zsh-packages
}

link-files() {
	echo "# Setting up linked files"
	link ~/.dotfiles/.zshrc ~/.zshrc
	link ~/.dotfiles/.bashrc ~/.bashrc
	link ~/.dotfiles/.nanorc ~/.nanorc
	link ~/.dotfiles/.dir_colors ~/.dir_colors
	link ~/.dotfiles/.gitconfig ~/.gitconfig
	sudo ln -s ~/.dotfiles/doi2bib.sh /usr/local/bin/doi2bib
}



install-linux-packages
install-diff-so-fancy

setup-zsh

link-files