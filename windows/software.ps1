. ./functions

# browsers
choco install -y GoogleChrome        --limit-output;
choco install -y chromium            --limit-output;
choco install -y firefox-dev   --pre --limit-output;

# Firefox settings
$files = ls -Path $ENV:APPDATA\Mozilla\Firefox\Profiles\*
foreach ($file in $files){
    makeSymbolicLinkFile "$file\user.js" "$ENV:UserProfile\Coding\.dotfiles\firefox\user.js"
    mkdir "$file\chrome"
    makeSymbolicLinkFile "$file\chrome\userChrome.css" "$ENV:UserProfile\Coding\.dotfiles\firefox\userChrome.css"
}

# Software
choco install -y vlc                 --limit-output;
choco install -y dropbox             --limit-output;
choco install -y steam               --limit-output;
choco install -y openvpn             --limit-output;
choco install -y winrar              --limit-output;

# Windows apps
# Doesnt work. Stupid