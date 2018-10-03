mklink C:\Users\%username%\.dotfiles\ %cd% /D
mklink C:\Users\%username%\.hyper.js C:\Users\%username%\.dotfiles\.hyper.js
mklink %appdata%\Code\User C:\Users\%username%\.dotfiles\vscode /D
rm C:\Users\%username%\.gitconfig
mklink C:\Users\%username%\.gitconfig C:\Users\%username%\.dotfiles\.gitconfig

for /d %%A in (C:\Users\marti\.IdeaIC20*) do (
    if exist "%%~fA" (
        rmdir "%%~fA"\config\keymaps
        mklink /D "%%~fA"\config\keymaps C:\Users\%username%\.dotfiles\intellij\keymaps
    )
)

set taskpath="C:\Users\marti\.dotfiles\windows\delete-downloads.cmd"

SchTasks /Create /SC ONSTART /TN "Delete browser downloads" /TR %taskpath% /F

pause