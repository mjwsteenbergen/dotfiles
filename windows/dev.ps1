# Enable Developer Mode
Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" "AllowDevelopmentWithoutDevLicense" 1

# Windows Subsystems/Features
choco install -y Microsoft-Hyper-V-All -source windowsFeatures
choco install -y Microsoft-Windows-Subsystem-Linux -source windowsfeatures

# Ubuntu
Invoke-WebRequest -Uri https://aka.ms/wsl-ubuntu-1604 -OutFile ~/Ubuntu.appx -UseBasicParsing
Add-AppxPackage -Path ~/Ubuntu.appx

#Dev tools
choco install git.install         --limit-output;
choco install git-lfs.install     --limit-output;
choco install dotnetcore-sdk      --limit-output;
choco install sourcetree          --limit-output;
choco install jdk8                --limit-output;
choco install docker              --limit-output;
choco install postman             --limit-output;
choco install jetbrainstoolbox    --limit-output;