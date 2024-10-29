
# requires: choco, winget, nodejs and git
# you can copy paste into terminal (powershell)

# Check for administrative privileges
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    # Re-run the script with elevated privileges
    Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}


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

# Install Neovim using Winget
winget install Neovim.Neovim

# Install Lazygit using Winget
winget install jesseduffield.lazygit

# Install LazyVim
git clone https://github.com/LazyVim/starter $env:LOCALAPPDATA\nvim
Remove-Item $env:LOCALAPPDATA\nvim\.git -Recurse -Force

setx LANG en_US.UTF-8
setx LC_ALL en_US.UTF-8
setx LC_CTYPE en_US.UTF-8

npm install -g tree-sitter-cli
npm install -g neovim

