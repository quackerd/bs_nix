#!/bin/sh

echo "Installing zsh and fonts..."
sudo dnf install zsh powerline-fonts

echo "Installing omzsh..."
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

echo "Changing default shell..."
chsh /bin/zsh

echo "Configuring zsh..."
cat ~/.zshrc | sed 's/SSH_KEY_PATH=.*/SSH_KEY_PATH=\"~\/.ssh\/id_ed25519\"/g' | sed 's/plugins=.*/plugins=\(git ssh-agent\)/g' | sed 's/ZSH_THEME=.*/ZSH_THEME=\"agnoster\"/g' > ~/.zshrc

echo "Adding custom commands..."
echo "alias update-grub=\"sudo grub2-mkconfig -o /boot/efi/EFI/fedora/grub.cfg\"" >> ~/.zshrc
echo "alias remove-kern=\"sudo dnf remove \$(dnf repoquery --installonly --latest-limit=-1 -q)\"" >> ~/.zshrc


