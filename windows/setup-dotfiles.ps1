function which($name) { Get-Command $name -ErrorAction SilentlyContinue | Select-Object Definition }

# Git 
choco install -y git -params '"/GitAndUnixToolsOnPath /WindowsTerminal"'

Update-SessionEnvironment

mkdir $env:UserProfile\Coding -Force

$dotfiles_path = "$env:UserProfile\Coding\.dotfiles\"

if(![System.IO.File]::Exists($dotfiles_path)){
  git clone https://github.com/mjwsteenbergen/dotfiles.git $dotfiles_path
  git config --global core.excludesfile "%USERPROFILE%\.gitignore"
  cmd.exe /C mklink C:\Users\%username%\.dotfiles\ $dotfiles_path /D
}

#REM Download VSCode
Invoke-WebRequest -Uri "https://update.code.visualstudio.com/latest/win32-x64-user/stable" -OutFile $env:UserProfile\Desktop\vscode.exe
 
#REM Install and run VSCode
C:\Users\$env:USERNAME\Desktop\vscode.exe /verysilent /suppressmsgboxes

Remove-Item $env:UserProfile\Desktop\vscode.exe

git remote set-url origin git@github.com:mjwsteenbergen/dotfiles.git
