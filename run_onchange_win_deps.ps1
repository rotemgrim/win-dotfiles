# make sure to run this script as an administrator
# requires: choco, winget, nodejs and git
# you can copy paste into terminal (powershell)

# Install Chocolatey if it's not already installed
if (-Not (Get-Command choco -ErrorAction SilentlyContinue)) {
    Set-ExecutionPolicy Bypass -Scope Process -Force
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

# Install git if it's not already installed
if (-Not (Get-Command git -ErrorAction SilentlyContinue)) {
    choco install git -y
}

# Install Node.js if it's not already installed
if (-Not (Get-Command node -ErrorAction SilentlyContinue)) {
    choco install nodejs -y
}

# Install dependencies using Chocolatey
choco install fd luarocks mingw ripgrep -y

# delete all neovim cache if exists
if (Test-Path "$env:LOCALAPPDATA\nvim-data\") {
    Remove-Item -Path "$env:LOCALAPPDATA\nvim-data\" -Recurse -Force
}

# Install Neovim using Winget
winget install Neovim.Neovim
winget upgrade Neovim.Neovim

# Install Lazygit using Winget
winget install jesseduffield.lazygit

winget install eza-community.eza starship yazi fzf

# Install LazyVim if it's not already installed
if (-Not (Test-Path $env:LOCALAPPDATA\nvim)) {
    git clone https://github.com/LazyVim/starter $env:LOCALAPPDATA\nvim
}
# remove git folder if it exists
if (Test-Path $env:LOCALAPPDATA\nvim\.git) {
    Remove-Item $env:LOCALAPPDATA\nvim\.git -Recurse -Force
}

# download zsh and extract 
#if (-Not (Test-Path $env:LOCALAPPDATA\zsh)) {
#    Invoke-WebRequest -Uri https://mirror.msys2.org/msys/x86_64/zsh-5.9-2-x86_64.pkg.tar.zst -OutFile $env:LOCALAPPDATA\zsh-5.9-2-x86_64.pkg.tar.zst
#    Expand-Archive -Path $env:LOCALAPPDATA\zsh-5.9-2-x86_64.pkg.tar.zst -DestinationPath $env:LOCALAPPDATA\zsh
#}

setx LANG en_US.UTF-8
setx LC_ALL en_US.UTF-8
setx LC_CTYPE en_US.UTF-8

npm install -g tree-sitter-cli
npm install -g neovim

