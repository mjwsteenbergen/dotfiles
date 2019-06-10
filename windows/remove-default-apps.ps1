#--- Uninstall unecessary applications that come with Windows out of the box ---
Write-Host "Uninstall some applications that come with Windows out of the box" -ForegroundColor "Yellow"

#Referenced to build script
# https://docs.microsoft.com/en-us/windows/application-management/remove-provisioned-apps-during-update
# https://github.com/jayharris/dotfiles-windows/blob/master/windows.ps1#L157
# https://gist.github.com/jessfraz/7c319b046daa101a4aaef937a20ff41f
# https://gist.github.com/alirobe/7f3b34ad89a159e6daa1
# https://github.com/W4RH4WK/Debloat-Windows-10/blob/master/scripts/remove-default-apps.ps1

function removeApp {
    Param ([string]$appName)
    Write-Output "Trying to remove $appName"
    Get-AppxPackage $appName -AllUsers | Remove-AppxPackage
    Get-AppXProvisionedPackage -Online | Where DisplayNam -like $appName | Remove-AppxProvisionedPackage -Online
}

$applicationList = @(
    "*.AdobePhotoshopExpress"
    "*.DisneyMagicKingdoms"
    "*.Duolingo-LearnLanguagesforFree"
    # "DolbyLaboratories.DolbyAccess"
    "*.EclipseManager"
    "*Autodesk*"
    "*BubbleWitch*"
    "*Dell*"
    "*Facebook*"
    "*Keeper*"
    "*MarchofEmpires*"
    "*Minecraft*"
    "*Netflix*"
    "*Plex*"
    # "SpotifyAB.SpotifyMusic"
    "*Solitaire*"
    "*.SlingTV"
    "*Twitter*"
    "ActiproSoftwareLLC.562882FEEB491" # Code Writer
    "G5*"
    "king.com*"
    "Microsoft.3DBuilder"
    "Microsoft.BingFinance"
    "Microsoft.BingNews"
    "Microsoft.BingSports"
    "Microsoft.BingWeather"
    "Microsoft.CommsPhone"
    "Microsoft.FreshPaint"
    "Microsoft.GetHelp"
    "Microsoft.Getstarted"
    "Microsoft.Messaging"
    "Microsoft.MicrosoftOfficeHub" #Get Office, and it's "Get Office365" notifications
    # "Microsoft.MicrosoftStickyNotes"
    # "Microsoft.MSPaint"
    # "Microsoft.Office.OneNote"
    "Microsoft.NetworkSpeedTest"
    "Microsoft.Office.Sway"
    # "Microsoft.Office.OneNote"
    "Microsoft.OneConnect"
    # "Microsoft.People"
    "Microsoft.Print3D"
    # "Microsoft.SkypeApp"
    # "Microsoft.Windows.Photos"
    # "Microsoft.WindowsCalculator"
    "Microsoft.WindowsAlarms"
    "Microsoft.WindowsPhone"
    "Microsoft.WindowsSoundRecorder"
    # "Microsoft.WindowsCommunicationsApps" #Calendar and Mail
    # "Microsoft.WindowsMaps"
    "Microsoft.XboxApp"
    "Microsoft.XboxIdentityProvider"
    "Microsoft.ZuneMusic"
    "Microsoft.ZuneVideo"
);

foreach ($app in $applicationList) {
    removeApp $app
}

Disable-WindowsOptionalFeature -Online -FeatureName "WindowsMediaPlayer" -NoRestart -WarningAction SilentlyContinue | Out-Null
