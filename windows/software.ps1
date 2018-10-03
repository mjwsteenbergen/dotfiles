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
choco install GoogleChrome        --limit-output;
choco install chromium            --limit-output;
choco install firefox-dev   --pre --limit-output;

# Software
choco install vlc                 --limit-output;
choco install dropbox             --limit-output;
choco install steam               --limit-output;
choco install openvpn             --limit-output;
choco install winrar              --limit-output;

# Windows apps
# Doesnt work. Stupid