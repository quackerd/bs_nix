#!/bin/sh

echo "Installing zsh..."
sudo dnf install -y zsh git

echo "Installing omzsh..."
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

echo "Configuring zsh..."
cat ~/.zshrc | sed 's/SSH_KEY_PATH=.*/SSH_KEY_PATH=\"~\/.ssh\/id_ed25519\"/g' | sed 's/plugins=.*/plugins=\(git ssh-agent zsh-autosuggestions zsh-syntax-highlighting\)/g' | sed 's/ZSH_THEME=.*/ZSH_THEME=\"gentoo\"/g' > ~/.zshrc

echo "Adding custom plugins..."
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
