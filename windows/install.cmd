mklink C:\Users\%username%\.hyper.js C:\Users\%username%\Coding\.dotfiles\.hyper.js
rmdir %appdata%\Code\User /S /Q
mklink %appdata%\Code\User C:\Users\%username%\Coding\.dotfiles\vscode /D
rm C:\Users\%username%\.gitconfig
mklink C:\Users\%username%\.gitconfig C:\Users\%username%\Coding\.dotfiles\.gitconfig

rmdir /Q C:\Users\%username%\source\repos
mklink C:\Users\%username%\source\repos\ C:\Users\%username%\Coding\ /D

for /d %%A in (C:\Users\%username%\.IdeaIC20*) do (
    if exist "%%~fA" (
        rmdir "%%~fA"\config\keymaps
        mklink /D "%%~fA"\config\keymaps C:\Users\%username%\Coding\.dotfiles\intellij\keymaps
    )
)

SchTasks /Create /SC ONSTART /TN "Delete browser downloads" /TR "powershell -command C:\Users\%username%\Coding\.dotfiles\windows\delete-downloads.ps1" /F

pause