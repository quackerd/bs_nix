#!/bin/sh

echo "Installing oh my zsh..."
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

echo "Installing custom plugins..."
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

echo "Configuring zsh..."
cat ~/.zshrc | sed 's/plugins=.*/plugins=\(git zsh-autosuggestions zsh-syntax-highlighting\)/g' | sed 's/ZSH_THEME=.*/ZSH_THEME=\"gentoo\"/g' | tee ~/.zshrc > /dev/null
