#!/bin/bash
# Sets up a clean home environment for a user from the dotfiles
#
# This script assumes all needed packages are already installed. For Arch this is handled via the setup script.
#
# Steps are:
# - Get id_rsa from bitwarden (manual step)
# - get wallhaven.json from bitwarden (manual step)
# - clone repos from the web
# - Copy/symlink files
# - load fonts
# - Add user to groups
# - setup nvm
# - setup neovim (manual step)
# - set rofi theme (manual step)
# - Install LSPs
echo ""
echo "This script should be run in a way that you can use multiple terminals at once."
echo "Either in a Window Manager, or with access to terminal multiplexing with something like tmux."
echo ""
echo "Step 1: Setting up SSH keys for private git access"
echo "Manual step: Copy id_rsa (from bitwarden) to ~/.ssh/id_rsa (press enter once done)"
mkdir ~/.ssh
cp ~/dotfiles/bootstrap/id_rsa.pub ~/.ssh/id_rsa.pub
read varname
echo ""
echo "Step 2: Setup the config for wallhaven access"
echo "Manual step: copy wallhaven.json (from bitwarden) to ~/.config/wallhaven.json (press enter once done)"
mkdir ~/.config
read varname
echo ""
echo "Step 3: Cloning repos from the web"
echo ""
mkdir ~/otherrepos
mkdir ~/repos
git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
git clone https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
git clone https://github.com/davidde/git ~/.oh-my-zsh/custom/plugins/git
git clone https://github.com/djui/alias-tips ~/.oh-my-zsh/custom/plugins/alias-tips
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting ~/.oh-my-zsh/custom/plugins/fast-syntax-highlighting
mkdir ~/org
git clone git@github.com:triorph/notes.git ~/org/roam
git clone git@github.com:triorph/newwp.git ~/repos/newwp
git clone https://github.com/sumneko/lua-language-server ~/otherrepos/lua-language-server
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
cd ~/otherrepos/lua-language-server
git submodule update --init --recursive
cd ~/dotfiles
git remote remove origin
git remote add origin git@github.com:/triorph/dotfiles.git
echo ""
echo "Step 3 complete."
echo ""
echo "Step 4: Copy/symlink files"
echo ""
mkdir ~/.local
mkdir ~/.local/bin
mkdir ~/.config/kitty
mkdir ~/.config/git
cd ~/repos/newwp
cargo install --path .
ln -s ~/dotfiles/config/bat ~/.config
ln -s ~/dotfiles/config/git/gitattributes ~/.gitattributes
cp ~/dotfiles/config/git/gitconfig ~/.gitconfig
ln -s ~/dotfiles/config/git/ignore ~/.config/git/ignore
ln -s ~/dotfiles/config/kitty/kitty-mac.conf ~/.config/kitty/kitty.conf
ln -s ~/dotfiles/config/kitty/kitty-common.conf ~/.config/kitty/kitty-common.conf
ln -s ~/dotfiles/config/kitty/font-mac.conf ~/.config/kitty/kitty-mac.conf
ln -s ~/dotfiles/config/nvim ~/.config
ln -s ~/dotfiles/config/tmux/tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/config/zsh/miek-aliases-etc ~/.oh-my-zsh/custom/plugins
ln -s ~/dotfiles/config/zsh/p10k.zsh ~/.p10k.zsh
ln -s ~/dotfiles/config/zsh/zshrc ~/.zshrc
ln -s ~/dotfiles/config/zsh/zshenv ~/.zshenv
ln -s ~/dotfiles/config/prettierrc.json ~/.prettierrc.json
ln -s ~/dotfiles/config/doom ~/.doom.d
ln -s ~/dotfiles/config/hammerspoon ~/.config/hammerspoon
echo "source ~/.zshenv" > ~/.xprofile
echo "Changing shell to zsh (may require password)"
chsh -s /bin/zsh
echo ""
echo "Please set your kitty theme `kitty +kitten themes`"
echo ""
read varname
echo ""
echo "Step 4 complete."
echo ""
echo "Step 6: Add user to groups (requires sudo access)"
echo ""
echo ""
echo "Step 6 complete"
echo ""
echo "Step 7: Setup nvm"
echo ""
echo "Step 7 complete"
echo ""
echo ""
echo "Step 8: setup neovim"
echo "Manual step: Enter \"nvim\" and run the setup commands to get it working. These are:"
echo ":lua require(\"plugins\")"
echo ":PackerSync"
echo "then once all run, close neovim (:q!), reopen and run:"
echo ":PackerCompile"
echo "and close again (:q!)"
echo "Press enter once done"
read varname
echo ""
echo "Step 9: Install LSPs"
echo ""
echo "Manual step: Install the sumneko_lua LSP and symlink to correct place"
echo ""
echo "cd ~/otherrepos/lua-language-server"
echo "cd 3rd/luamake"
echo "./compile/install.sh"
echo "cd ../../"
echo "3rd/luamake/luamake rebuild"
echo "ln -s ~/otherrepos/lua-language-server ~/.local/share/lua-language-server"
echo ""
echo "Press enter to continue"
read varname
echo ""
echo "Step 10 complete"
echo ""
echo ""
echo ""
echo "Step 10: Manual step, since it takes so long. Please install doom emacs from the command line with `doom install`"
echo "press enter to continue"
read varname
echo "Step 10 complete"
echo ""
echo "Setup complete! You may have to restart your window-manager / reboot for this to take effect"
echo ""
