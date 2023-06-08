#!/bin/sh

echo "Installing Oh My Zsh"
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
git clone git://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/plugins/zsh-autosuggestions
git clone git://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/plugins/zsh-syntax-highlighting
echo "source ~/.oh-my-zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc
sed -io 's/^plugins=.*/plugins=(autojump git brew common-aliases zsh-autosuggestions copydir copyfile encode64 node osx sublime tmux xcode pod docker git-extras git-prompt)/' ~/.zshrc
sed -io 's/^ZSH_THEME.*/ZSH_THEME="powerlevel10k/powerlevel10k"/' ~/.zshrc
echo "Open/restart the terminal to setup the powerlevel10k theme for Oh My Zsh."
echo "Read more: https://github.com/romkatv/powerlevel10k#oh-my-zsh"

echo "Installing Homebrew"
if test ! $(which brew); then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" \
        && (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/thicolares/.zshrc \
        && eval "$(/opt/homebrew/bin/brew shellenv)"
fi
brew update
echo "Installing Homebrew Packages"
brew tap homebrew/bundle
brew bundle

echo "Installing XCode CLI Tool"
xcode-select --install

#echo "Installing Tmux Settings"
#I'm no longer using Tmux 🤔
#git clone https://github.com/gpakosz/.tmux.git ~/.tmux
#ln -s ~/.tmux/.tmux.conf ~/.tmux.conf
#cp ~/.tmux/.tmux.conf.local ~/

echo "Installing VIM settings"
git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh

echo "Configurating Git"
cp gitignore_global ~/.gitignore_global
git config --global core.excludesfile ~/.gitignore_global
git config --global merge.tool diffmerge
git config --global merge.conflictstyle diff3
git config --global mergetool.prompt false
git config --global alias.co checkout
git config --global alias.ci commit
git config --global alias.st status
git config --global alias.br branch
git config --global core.editor $(which vim)
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --"
git config --global alias.tree "log --graph --full-history --all --color --date=short --pretty=format:'%Cred%x09%h %Creset%ad%Cblue%d %Creset %s %C(bold)(%an)%Creset'"
git config --global init.defaultBranch main

echo "Enabling Services"
open /Applications/Tiles.app

echo "Installing Oh My Zsh plugins"
echo "  Installing zsh-syntax-highlighting"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

echo "  Installing zsh-completions"
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions

echo "  Installing zsh-autosuggestion"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions


cat << EndOfInstructions
Now run:
  vim ~/.zshrc

Add the names of the cloned repositories to the plugin list:
  plugins=(
    docker
    docker-compose
    git
    python
    zsh-syntax-highlighting
    zsh-autosuggestions
    zsh-completions
  )

  # command for zsh-completions
  autoload -U compinit && compinit

After saving ~/.zshrc, run:
  source ~/.zshrc
EndOfInstructions
