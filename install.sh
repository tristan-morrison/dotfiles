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


# Create Screen Captures directory
mkdir -p "${HOME}/Documents/Screen Captures"

# Set macOS defaults
"${PWD}./macos.sh"

echo 🔵 Adding shortcut for Downloads directory
ln -s "${HOME}/Downloads" "${HOME}/d"

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
rm "${HOME}/.oh-my-zsh/lib/key-bindings.zsh"

echo 🔵 Installing Powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${PWD}/zsh/custom/themes/powerlevel10k

echo 🔵 Installing other ZSH plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${PWD}/zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/jeffreytse/zsh-vi-mode "${PWD}/zsh/custom/plugins/zsh-vi-mode"

echo 🔵 Replacing the default Git Config
ln -sf "${PWD}/git/.gitconfig" "${HOME}"

echo 🔵 Linking misc files
ln -sf "${PWD}/zsh/.zshrc" "${HOME}"
ln -sf "${PWD}/zsh/.zprofile" "${HOME}"
ln -sf "${PWD}/zsh/.p10k.zsh" "${HOME}"
ln -sf "${PWD}/zsh/.screenrc" "${HOME}"
ln -sf "${PWD}/misc/.editorconfig" "${HOME}/site"
sudo mkdir -p "/etc/docker/"
sudo ln "${PWD}/docker/daemon.json" "/etc/docker/"

echo 🔵 Hard linking common files from \`code-share\`
ln "${HOME}/site/git/code-share/misc/images/mambo.jpg" "${HOME}/Documents/"
ln "${HOME}/site/git/code-share/misc/images/max_patiiuk_old.jpg" "${HOME}/Documents/"
ln "${HOME}/site/git/code-share/misc/images/max_patiiuk_1x1.jpg" "${HOME}/Documents/"
ln "${HOME}/site/git/code-share/misc/images/max_patiiuk.jpg" "${HOME}/Documents/"
ln "${HOME}/site/git/code-share/misc/images/wolf.jpg" "${HOME}/Documents/"

echo 🔵 Initializing Dir Explorer
(
  cd "${HOME}/site/python/dir-explorer"
  python -m venv venv
  venv/bin/pip install -r requirements.txt
)

echo 🔵 Initializing Text Hoarder
(
  cd "${HOME}/site/javascript/text-hoarder"
  npm i
)

echo 🔵 Installing Docker Watcher
(
  cd "${HOME}/site/git/specify-tools/docker_container"
  python -m venv venv
  venv/bin/pip install -r requirements.txt
)

echo 🔵 Linking launchctl .plist file
mkdir -p ${HOME}/Library/LaunchAgents/
ln -sf "${PWD}/scripts/uk.patii.max.task.plist" "${HOME}/Library/LaunchAgents/"

echo 🔵 Update VS Code Icon
mv "/Applications/Visual Studio Code.app/Contents/Resources/Code.icns" "/Applications/Visual Studio Code.app/Contents/Resources/Code_original.icns"
cp "./vscode/icon.icns" "/Applications/Visual Studio Code.app/Contents/Resources/Code.icns"

echo 🔴 \#\#\# Private part \#\#\#
echo 🔴 This relies on a private \`maxpatiiuk/private-dotfiles\` repository
echo 🔴 You should comment out this part or replace it with your own
echo 🔴 private repository

(
  cd "${HOME}/site/git/"
  git clone https://github.com/maxpatiiuk/private-dotfiles.git
  cd private-dotfiles
  ./install.sh
)
