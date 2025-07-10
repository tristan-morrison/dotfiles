echo 🔴 WARNING!
echo 🔴 Read the contents of this file carefully before running it

PWD="${HOME}/site/git/dotfiles"

# If system is not Darwin, exit with code 1:
if [ "$(uname 2> /dev/null)" != "Darwin" ]; then
  echo 🔴 This install script works only on macOS.
  echo 🔴 Modifications may be required to make it work on other platforms.
  exit 1
fi

echo 🔵 Install xcode Developer Tools
xcode-select --install

echo 🔵 Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew update
brew doctor
brew tap homebrew/cask-versions

echo 🔵 Install Homebrew Formulae and Casks
brew install curl
brew install wget
brew install git
brew install emacs
brew install git-lfs
brew install fnm
brew install ffmpeg
brew install gnupg
brew install pinentry-mac
brew install coreutils
brew install gcc
brew install grep
brew install openssh
brew install awk
brew install gh
brew install htop
brew install gdal
brew install python
brew install lima
brew install p11-kit
brew install --cask iterm2
brew install --cask karabiner-elements
brew install --cask 1password
brew install --cask espanso
brew install --cask visual-studio-code
brew install --cask opensc
brew install --cask opensc-app

# Create Screen Captures directory
mkdir -p "${HOME}/Documents/Screen Captures"

# Set macOS defaults
"${PWD}./macos.sh"

echo 🔵 Creating directories
mkdir -p "${HOME}/site/git"

echo 🔵 Cloning Git repos
(
  cd "${HOME}/site/git"
  git clone https://github.com/tristan-morrison/dotfiles.git
)

echo 🔵 Installing Node.js
fnm install 20

echo 🔵 Install global Python dependencies
pip install wheel

echo 🔵 Install global NPM dependencies
npm install -g npm-check-updates
npm install -g typescript-language-server

echo 🔵 Installing oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo 🔵 Deleting default oh-my-zsh configs
rm "${HOME}/.oh-my-zsh/lib/bzr.zsh"
rm "${HOME}/.oh-my-zsh/lib/diagnostics.zsh"
rm "${HOME}/.oh-my-zsh/lib/directories.zsh"

echo 🔵 Installing Powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${PWD}/zsh/custom/themes/powerlevel10k

echo 🔵 Installing other ZSH plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${PWD}/zsh/custom/plugins/zsh-syntax-highlighting

echo 🔵 Replacing the default Git Config
ln -sf "${PWD}/git/.gitconfig" "${HOME}"

echo 🔵 Linking misc files
ln -sf "${PWD}/zsh/.zshrc" "${HOME}"
ln -sf "${PWD}/zsh/.zprofile" "${HOME}"
ln -sf "${PWD}/zsh/.p10k.zsh" "${HOME}"
ln -sf "${PWD}/misc/.emacs" "${HOME}/.emacs"
ln -sf "${PWD}/misc/.editorconfig" "${HOME}/site"
ln -sf "${PWD}/karabiner/karabiner.json" "${HOME}/.config/karabiner/karabiner.json"

echo 🔵 Linking launchctl .plist file
mkdir -p ${HOME}/Library/LaunchAgents/
ln -sf "${PWD}/scripts/farm.bisonhollow.task.plist" "${HOME}/Library/LaunchAgents/"

# echo 🔴 \#\#\# Private part \#\#\#
# echo 🔴 This relies on a private \`maxpatiiuk/private-dotfiles\` repository
# echo 🔴 You should comment out this part or replace it with your own
# echo 🔴 private repository

# (
#   cd "${HOME}/site/git/"
#   git clone https://github.com/maxpatiiuk/private-dotfiles.git
#   cd private-dotfiles
#   ./install.sh
# )
