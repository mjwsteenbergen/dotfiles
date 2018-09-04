function Refresh-Environment {
    $locations = 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment',
                 'HKCU:\Environment'

    $locations | ForEach-Object {
        $k = Get-Item $_
        $k.GetValueNames() | ForEach-Object {
            $name  = $_
            $value = $k.GetValue($_)
            Set-Item -Path Env:\$name -Value $value
        }
    }

    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
}

### Chocolatey
Write-Host "Installing Desktop Utilities..." -ForegroundColor "Yellow"
if ((which cinst) -eq $null) {
    iex (new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1')
    Refresh-Environment
    choco feature enable -n=allowGlobalConfirmation
}

#--- Git ---
choco install -y git -params '"/GitAndUnixToolsOnPath /WindowsTerminal"'

#--- Windows Subsystems/Features ---
choco install -y Microsoft-Hyper-V-All -source windowsFeatures
choco install -y Microsoft-Windows-Subsystem-Linux -source windowsfeatures

# browsers
choco install GoogleChrome        --limit-output;
choco install chromium            --limit-output;
choco install firefox-dev   --pre --limit-output;

#Dev tools
choco install git.install         --limit-output;
choco install git-lfs.install     --limit-output;
choco install dotnetcore-sdk      --limit-output;
choco install sourcetree          --limit-output;
choco install jdk8                --limit-output;
choco install docker              --limit-output;
choco install postman             --limit-output;
choco install jetbrainstoolbox    --limit-output;

# Software
choco install vlc                 --limit-output;
choco install dropbox             --limit-output;
choco install steam               --limit-output;
choco install openvpn             --limit-output;
choco install winrar              --limit-output;

# Windows apps
# Doesnt work. Stupid