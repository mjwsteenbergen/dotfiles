. ./functions

# Base
choco install -y git-lfs.install     --limit-output;

# Enable Developer Mode
Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" "AllowDevelopmentWithoutDevLicense" 1

# Linking
## VSCode
if((Test-Path -Path "$env:APPDATA\Code" )){
    makeSymbolicLinkFolder "$env:APPDATA\Code\User" "$ENV:UserProfile\Coding\.dotfiles\vscode"
}

if((Test-Path -Path "$env:APPDATA\Code - Insiders" )){
    makeSymbolicLinkFolder "$env:APPDATA\`"Code - Insiders`"\User" "$ENV:UserProfile\Coding\.dotfiles\vscode"
}

## Git
makeSymbolicLinkFile "$ENV:UserProfile\.gitconfig" "$ENV:UserProfile\Coding\.dotfiles\.gitconfig"
makeSymbolicLinkFile "$ENV:UserProfile\.gitignore" "$ENV:UserProfile\Coding\.dotfiles\.gitignore"

# choco install -y sourcetree          --limit-output;

## SSH
# Create SSH key if none exist
if (!(Test-Path "$env:UserProfile\.ssh")) {
    mkdir $env:UserProfile\.ssh
    ssh-keygen -f $env:UserProfile\.ssh\id_rsa -t ed25519 -N '""'
}
makeSymbolicLinkFile "$ENV:UserProfile\.ssh\config" "$ENV:UserProfile\Coding\.dotfiles\ssh-config"

## IntelliJ
$files = ls -Path $ENV:UserProfile\.IdeaIC20*
foreach ($file in $files){
    makeSymbolicLinkFolder "$file\config\keymaps" "$ENV:UserProfile\Coding\.dotfiles\intellij\keymaps"
}

# Linux

## Windows Subsystems/Features
choco install -y Microsoft-Windows-Subsystem-Linux -source windowsfeatures

## Ubuntu
# Invoke-WebRequest -Uri https://aka.ms/wsl-ubuntu-1604 -OutFile ~/Ubuntu.appx -UseBasicParsing
# Add-AppxPackage -Path ~/Ubuntu.appx

choco install -y vcxsrv              --limit-output;

## Set HyperConfig
#makeSymbolicLinkFile "C:\Users\%username%\.hyper.js C:\Users\%username%\Coding\.dotfiles\.hyper.js"

# Web development
choco install -y postman             --limit-output;

# Java 
choco install -y jdk8                --limit-output;
choco install -y jdk11               --limit-output;
choco install -y jetbrainstoolbox    --limit-output;

# Windows development
makeSymbolicLinkFolder "$ENV:UserProfile\source\repos\" "$ENV:UserProfile\Coding\"
choco install -y dotnetcore-sdk      --limit-output;


Enable-WindowsOptionalFeature -Online -FeatureName containers -All
choco install -y Microsoft-Hyper-V-All -source windowsFeatures
choco install -y docker-for-windows  --limit-output;
