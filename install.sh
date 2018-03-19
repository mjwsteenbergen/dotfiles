sudo apt-get install zsh dotnet htop maven
chsh -s $(which zsh)

# Linking all files
ln -s ~/.dotfiles/.zshrc ~/.zshrc
ln -s ~/.dotfiles/vscode/keybindings.json ~/.config/Code/User/
ln -s ~/.dotfiles/vscode/settings.json ~/.config/Code/User/
ln -s ~/.dotfiles/.nanorc ~/.nanorc
ln -s ~/.dotfiles/.bashrc ~/.bashrc
ln -s ~/.dotfiles/.bash_aliases ~/.bash_aliases
ln -s ~/.dotfiles/.dir_colors ~/.dir_colors

# Install oh my zsh
export ZSH="$HOME/.oh-my-zsh"; sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zdharma/fast-syntax-highlighting.git $ZSH_CUSTOM/plugins/fast-syntax-highlighting