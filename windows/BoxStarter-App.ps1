# Description: Boxstarter Script
# Author: Martijn Steenbergen
# Automatic Removal of those pesty apps

Disable-UAC

function executeScript {
    $baseUri = "https://raw.githubusercontent.com/mjwsteenbergen/dotfiles/master/windows/"
    Param ([string]$script)
    write-host "executing $baseUri/$script ..."
    iex ((new-object net.webclient).DownloadString("$baseUri/$script"))
}

#--- Execute Scripts ---
executeScript "remove-default-apps.ps1";
executeScript "privacy.ps1";

Update-SessionEnvironment

#--- reenabling critial items ---
Enable-UAC
Enable-MicrosoftUpdate
Install-WindowsUpdate -acceptEula
