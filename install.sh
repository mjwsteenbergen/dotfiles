#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

function link {
	[[ -e $2 ]] && rm "$2"
	ln -s $1 "$2"
}

install-linux-packages() {
	echo "# Install Linux Packages"
	sudo apt-get update
	sudo apt-get upgrade -y
	sudo apt-get install zsh htop curl zip -y

	if ! command -v zoxide &> /dev/null
	then
		echo "## Installing Zoxide"
		curl -sS https://webinstall.dev/zoxide | bash
	fi

}

install-macos-packages() {
	echo "# Install MacOS Packages"

	if ! command -v brew &> /dev/null
	then
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
		echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/martijnsteenbergen/.zprofile
	fi

	if ! command -v zoxide &> /dev/null
	then
		brew install zoxide
	fi

	if ! command -v direnv &> /dev/null
	then
		brew install direnv
	fi


	link ~/.dotfiles/vscode/settings.json    ~/Library/Application\ Support/Code/User/settings.json
	link ~/.dotfiles/vscode/keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json
	link ~/.dotfiles/vscode/snippets         ~/Library/Application\ Support/Code/User/snippets

}

install-packages() {
	if [[ $OSTYPE == 'darwin'* ]]; then
		install-macos-packages
	fi

	if command -v apt-get &> /dev/null
	then
		install-linux-packages
	fi

	# if ! command -v nvm &> /dev/null
	# then
	# 	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
	# fi

}

setup-zsh() {
	if [ ! "/bin/zsh" == "$SHELL"  ]; then 
		echo "ZSH is not set as default shell. Please run"
		echo "chsh -s \$(which zsh)"
	fi
	
	# Install oh my zsh
	if [ ! -e "$HOME/.oh-my-zsh" ]; then 
		export ZSH="$HOME/.oh-my-zsh"
		sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
	fi

	setup-zsh-packages() {
		echo "# Installing ZSH Plugins"
		[ ! -e "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ] && git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
		[ ! -e "$HOME/.oh-my-zsh/custom/plugins/F-Sy-H" ] && git clone https://github.com/z-shell/F-Sy-H.git $HOME/.oh-my-zsh/custom/plugins/F-Sy-H
		[ ! -e "$HOME/.oh-my-zsh/custom/plugins/zsh-better-npm-completion" ] && git clone https://github.com/lukechilds/zsh-better-npm-completion $HOME/.oh-my-zsh/custom/plugins/zsh-better-npm-completion
		[ ! -e "$HOME/.oh-my-zsh/custom/plugins/alias-tips" ] && git clone https://github.com/djui/alias-tips.git $HOME/.oh-my-zsh/custom/plugins/alias-tips
		[ ! -e "$HOME/.oh-my-zsh/custom/plugins/nx-completion" ] && git clone https://github.com/jscutlery/nx-completion.git $HOME/.oh-my-zsh/custom/plugins/nx-completion
		
		
		[ ! -e "~/.zsh-plugins/" ] && mkdir ~/.zsh-plugins/
		[ ! -e "~/.zsh-plugins/zsh-autocomplete" ] && git clone --depth 1 https://github.com/marlonrichert/zsh-autocomplete ~/.zsh-plugins/zsh-autocomplete
		
		sudo chmod -R 755 $HOME/.oh-my-zsh/custom/plugins/
	}
	
	setup-zsh-packages
}

link-files() {
	echo "# Setting up linked files"
	link $SCRIPT_DIR ~/.dotfiles
	link ~/.dotfiles/.zshrc ~/.zshrc
	link ~/.dotfiles/.bashrc ~/.bashrc
	link ~/.dotfiles/.nanorc ~/.nanorc
	link ~/.dotfiles/.dir_colors ~/.dir_colors
	link ~/.dotfiles/.gitconfig ~/.gitconfig
}


link-files
setup-zsh
install-packages