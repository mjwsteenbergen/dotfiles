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

# browsers
choco install -y GoogleChrome        --limit-output;
choco install -y chromium            --limit-output;
choco install -y firefox-dev   --pre --limit-output;

# Software
choco install -y vlc                 --limit-output;
choco install -y dropbox             --limit-output;
choco install -y steam               --limit-output;
choco install -y openvpn             --limit-output;
choco install -y winrar              --limit-output;

# Windows apps
# Doesnt work. Stupid