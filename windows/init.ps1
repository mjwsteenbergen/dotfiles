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

function which($name) { Get-Command $name -ErrorAction SilentlyContinue | Select-Object Definition }

### Chocolatey
Write-Host "Installing Desktop Utilities..." -ForegroundColor "Yellow"
if ((which cinst) -eq $null) {
    iex (new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1')
    Refresh-Environment
    choco feature enable -n=allowGlobalConfirmation
}

#--- Git ---
choco install -y git -params '"/GitAndUnixToolsOnPath /WindowsTerminal"'

mkdir $env:UserProfile\Coding -Force

$dotfiles_path = "$env:UserProfile\Coding\dotfiles\"

if(![System.IO.File]::Exists($dotfiles_path)){
  git clone https://github.com/mjwsteenbergen/dotfiles.git $dotfiles_path
  cmd.exe /C mklink C:\Users\%username%\.dotfiles\ $dotfiles_path /D
}

choco install -y vscode --limit-output --params "/NoDesktopIcon";
