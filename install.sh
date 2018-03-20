#bin/bash

# dotnet
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg 
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg 
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-ubuntu-xenial-prod xenial main" > /etc/apt/sources.list.d/dotnetdev.list'
sudo apt-get install apt-transport-https
sudo apt-get update

#Install
sudo apt-get install zsh dotnet-sdk-2.1.101 htop maven 

chsh -s $(which zsh)

# Install oh my zsh
export ZSH="$HOME/.oh-my-zsh"; sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Linking all files
function link {
	rm $2
	ln -s $1 $2
}


link ~/.dotfiles/.zshrc ~/.zshrc
link ~/.dotfiles/vscode/keybindings.json ~/.config/Code/User/
link ~/.dotfiles/vscode/settings.json ~/.config/Code/User/
link ~/.dotfiles/.nanorc ~/.nanorc
link ~/.dotfiles/.dir_colors ~/.dir_colors


git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/plugins/zsh-autosuggestions
git clone https://github.com/zdharma/fast-syntax-highlighting.git $HOME/.oh-my-zsh/plugins/fast-syntax-highlighting
