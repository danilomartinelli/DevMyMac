#!/bin/sh

# Color Variables
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Ask for the administrator password upfront.
sudo -v

# Keep Sudo Until Script is finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Install Homebrew
echo "Installing Homebrew"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update
brew upgrade --all
brew install mas
    
# Install Apps
    
mas install 497799835 # XCode
mas install 1278508951 # Trello
mas install 946399090 # Telegram
mas install 1147396723 # WhatsApp
xcode-select --install

# Check if OSX Command line tools are installed
if type xcode-select >&- && xpath=$( xcode-select --print-path ) &&
    test -d "${xpath}" && test -x "${xpath}" ; then
    ###############################################################################
    # Computer Settings                                                           #
    ###############################################################################
    echo -e "${RED}Enter your computer name please?${NC}"
    read cpname
    echo -e "${RED}Please enter your name?${NC}"
    read name
    echo -e "${RED}Please enter your git email?${NC}"
    read email

    clear

    sudo scutil --set ComputerName "$cpname"
    sudo scutil --set HostName "$cpname"
    sudo scutil --set LocalHostName "$cpname"
    defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "$cpname"

    defaults write -g ApplePressAndHoldEnabled -bool false
    defaults write com.apple.finder ShowPathbar -bool true
    defaults write com.apple.finder ShowStatusBar -bool true
    defaults write NSGlobalDomain KeyRepeat -int 0.02
    defaults write NSGlobalDomain InitialKeyRepeat -int 12
    chflags nohidden ~/Library


    git config --global user.name "$name"

    git config --global user.email "$email"

    git config --global color.ui true

    ###############################################################################
    # Install Applications                                                        #
    ###############################################################################

    clear
    
    echo -e "${RED}Install NodeJS? ${NC}[y/N]"
    read -n 1 -r
    echo    # (optional) move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
      # Install Nodejs
      echo "Installing NVM"
      curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.4/install.sh | bash

      export NVM_DIR="/Users/${id -un}/.nvm"
      [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm so we dont have to reboot the terminal

      #Installing Nodejs

      echo "Installing Nodejs"
      nvm install node
      nvm use node

      npm install -g typescript

    fi

    clear
    echo -e "${RED}Install Unity3D? ${NC}[y/N]"
    read -n 1 -r
    echo    # (optional) move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
      brew cask install unity unity-web-player

    fi

    clear
    echo -e "${RED}Install Python? ${NC}[y/N]"
    read -n 1 -r
    echo    # (optional) move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
      # Install Python
      brew install python
      brew install python3
      sudo easy_install pip
      sudo pip install --upgrade pip
      sudo pip install virtualenv
    fi

    clear
    echo -e "${RED}Install Ruby?${NC} [y/N]"
    read -n 1 -r
    echo    # (optional) move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
      # Install ruby
      brew install gpg
      command curl -sSL https://rvm.io/mpapis.asc | gpg --import -
      \curl -L https://get.rvm.io | bash -s stable
      source ~/.rvm/scripts/rvm
      rvm install ruby-2.3.1

      gem install bundler
      gem install rails
    fi

    clear
    echo -e "${RED}Install Cocoapods?${NC} [y/N]"
    read -n 1 -r
    echo    # (optional) move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
      # Install Cocoapods
      sudo gem install cocoapods
    fi

    clear
    echo -e "${RED}Setup for Java Devlopment? ${NC}[y/N]"
    read -n 1 -r
    echo    # (optional) move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
      brew cask install \
      java \
      eclipse-ide \
      eclipse-java
    fi

    clear
    echo -e "${RED}Setup For Android Developemnt?${NC} [y/N]"
    read -n 1 -r
    echo    # (optional) move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
      brew cask install \
      java \
      eclipse-ide \
      eclipse-java \
      android-studio

      brew install android-sdk
    fi

    clear
    echo -e "${RED}Install Databases? ${NC}[y/N]"
    read -n 1 -r
    echo    # (optional) move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
      brew install mysql
      brew install postgresql
      brew install mongo
      brew install redis
      brew install elasticsearch

      # Install mysql workbench
      # Install Cask
      brew install caskroom/cask/brew-cask
      brew cask install --appdir="/Applications" mysqlworkbench
    fi


    clear
    # Install Homebrew Apps
    echo "Installing Homebrew Command Line Tools"
    
    brew cask install \
    virtualbox \
    docker
    
    brew install \
    tree \
    wget \
    ack \
    bash-completion \
    kubectl \
    minikube \
    git

    # Install EMacs
    echo "Installing EMacs"
    brew install emacs --with-cocoa
    brew linkapps emacs

    brew tap caskroom/cask

    echo "Installing Apps"
    brew cask install \
    google-chrome \
    github-desktop \
    visual-studio-code \
    gitkraken \
    mamp \
    typora \
    google-drive \
    iterm2 \
    notion \
    postman \
    spotify \
    slack \
    google-cloud-sdk

    echo "Cleaning Up Cask Files"
    brew cask cleanup

    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

    clear

    echo "${GREEN}Thanks for using DevMyMac! If you liked it, make sure to go to the Github Repo (https://github.com/adamisntdead/DevMyMac) and Star it! If you have any issues, just put them there, and all suggestions and contributions are appreciated!"

else
   echo "Need to install the OSX Command Line Tools (or XCode) First! Starting Install..."
   # Install XCODE Command Line Tools
   xcode-select --install
fi
