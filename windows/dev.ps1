. ./functions

# Base
choco install -y git-lfs.install     --limit-output;
choco install -y sourcetree          --limit-output;

# Enable Developer Mode
Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" "AllowDevelopmentWithoutDevLicense" 1

# Linux

## Windows Subsystems/Features
choco install -y Microsoft-Windows-Subsystem-Linux -source windowsfeatures

## Ubuntu
# Invoke-WebRequest -Uri https://aka.ms/wsl-ubuntu-1604 -OutFile ~/Ubuntu.appx -UseBasicParsing
# Add-AppxPackage -Path ~/Ubuntu.appx

choco install -y vcxsrv              --limit-output;

## Set HyperConfig
#makeSymbolicLinkFile "C:\Users\%username%\.hyper.js C:\Users\%username%\Coding\.dotfiles\.hyper.js"

# Csharp
choco install -y postman             --limit-output;

# Java 
choco install -y jdk8                --limit-output;
choco install -y jdk11               --limit-output;
choco install -y jetbrainstoolbox    --limit-output;

# Windows development
choco install -y dotnetcore-sdk      --limit-output;
choco install -y Microsoft-Hyper-V-All -source windowsFeatures
choco install -y docker-for-windows  --limit-output;
