. ./functions.ps1

# Check to see if we are currently running "as Administrator"
if (!(Verify-Elevated)) {
   $newProcess = new-object System.Diagnostics.ProcessStartInfo "PowerShell";
   $newProcess.Arguments = $myInvocation.MyCommand.Definition;
   $newProcess.Verb = "runas";
   [System.Diagnostics.Process]::Start($newProcess);

   exit
}

###############################################################################
### Privacy                                                                   #
###############################################################################
Write-Host "Configuring Privacy..." -ForegroundColor "Yellow"

# Ensure necessary registry paths
if (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo")) {New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" -Type Folder | Out-Null}
if (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Input")) {New-Item -Path "HKCU:\SOFTWARE\Microsoft\Input" -Type Folder | Out-Null}
if (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Input\TIPC")) {New-Item -Path "HKCU:\SOFTWARE\Microsoft\Input\TIPC" -Type Folder | Out-Null}

# General: Don't let apps use advertising ID for experiences across apps: Allow: 1, Disallow: 0
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" "Enabled" 0

# General: Disable SmartScreen Filter: Enable: 1, Disable: 0
# Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost" "EnableWebContentEvaluation" 0

# General: Disable key logging & transmission to Microsoft: Enable: 1, Disable: 0
# Disabled when Telemetry is set to Basic
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Input\TIPC" "Enabled" 0

# General: Opt-out from websites from accessing language list: Opt-in: 0, Opt-out 1
Set-ItemProperty "HKCU:\Control Panel\International\User Profile" "HttpAcceptLanguageOptOut" 1

# General: Disable SmartGlass: Enable: 1, Disable: 0
# Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\SmartGlass" "UserAuthPolicy" 0

# General: Disable SmartGlass over BlueTooth: Enable: 1, Disable: 0
# Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\SmartGlass" "BluetoothPolicy" 0

# Camera: Don't let apps use camera: Allow, Deny
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{E5323777-F976-4f5b-9B55-B94699C46E44}" "Value" "Deny"

# Microphone: Don't let apps use microphone: Allow, Deny
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{2EEF81BE-33FA-4800-9670-1CD474972C3F}" "Value" "Deny"

# Sync Settings: Disable automatically syncing settings with other Windows 10 devices
# Theme
Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Personalization" "Enabled" 0
# Internet Explorer
Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\SettingSync\Groups\BrowserSettings" "Enabled" 0
# Passwords
Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Credentials" "Enabled" 0
# Language
Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Language" "Enabled" 0
# Accessibility / Ease of Access
Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Accessibility" "Enabled" 0
# Other Windows Settings
Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Windows" "Enabled" 0

# Notifications: Don't let apps access notifications: Allow, Deny
# Build 1511
# Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{21157C1F-2651-4CC1-90CA-1F28B02263F6}" "Value" "Deny"
# Build 1607, 1709
# if (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{52079E78-A92B-413F-B213-E8FE35712E72}")) {New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{52079E78-A92B-413F-B213-E8FE35712E72}" -Type Folder | Out-Null}
# Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{52079E78-A92B-413F-B213-E8FE35712E72}" "Value" "Deny"

# Speech, Inking, & Typing: Stop "Getting to know me"
if (!(Test-Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization")) {New-Item -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization" -Type Folder | Out-Null}
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\InputPersonalization" "RestrictImplicitTextCollection" 1
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\InputPersonalization" "RestrictImplicitInkCollection" 1
if (!(Test-Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore")) {New-Item -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" -Type Folder | Out-Null}
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" "HarvestContacts" 0
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Personalization\Settings" "AcceptedPrivacyPolicy" 0

# Account Info: Don't let apps access name, picture, and other account info: Allow, Deny
if (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{C1D23ACC-752B-43E5-8448-8D0E519CD6D6}")) {New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{C1D23ACC-752B-43E5-8448-8D0E519CD6D6}" -Type Folder | Out-Null}
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{C1D23ACC-752B-43E5-8448-8D0E519CD6D6}" "Value" "Deny"

# Contacts: Don't let apps access contacts: Allow, Deny
# if (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{7D7E8402-7C54-4821-A34E-AEEFD62DED93}")) {New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{7D7E8402-7C54-4821-A34E-AEEFD62DED93}" -Type Folder | Out-Null}
# Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{7D7E8402-7C54-4821-A34E-AEEFD62DED93}" "Value" "Deny"

# Calendar: Don't let apps access calendar: Allow, Deny
# if (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{D89823BA-7180-4B81-B50C-7E471E6121A3}")) {New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{D89823BA-7180-4B81-B50C-7E471E6121A3}" -Type Folder | Out-Null}
# Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{D89823BA-7180-4B81-B50C-7E471E6121A3}" "Value" "Deny"

# Call History: Don't let apps access call history: Allow, Deny
if (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{8BC668CF-7728-45BD-93F8-CF2B3B41D7AB}")) {New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{8BC668CF-7728-45BD-93F8-CF2B3B41D7AB}" -Type Folder | Out-Null}
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{8BC668CF-7728-45BD-93F8-CF2B3B41D7AB}" "Value" "Deny"

# Email: Don't let apps read and send email: Allow, Deny
# if (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{9231CB4C-BF57-4AF3-8C55-FDA7BFCC04C5}")) {New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{9231CB4C-BF57-4AF3-8C55-FDA7BFCC04C5}" -Type Folder | Out-Null}
# Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{9231CB4C-BF57-4AF3-8C55-FDA7BFCC04C5}" "Value" "Deny"

# Messaging: Don't let apps read or send messages (text or MMS): Allow, Deny
if (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{992AFA70-6F47-4148-B3E9-3003349C1548}")) {New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{992AFA70-6F47-4148-B3E9-3003349C1548}" -Type Folder | Out-Null}
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{992AFA70-6F47-4148-B3E9-3003349C1548}" "Value" "Deny"

# Redios: Don't let apps control radios (like Bluetooth): Allow, Deny
if (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{A8804298-2D5F-42E3-9531-9C8C39EB29CE}")) {New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{A8804298-2D5F-42E3-9531-9C8C39EB29CE}" -Type Folder | Out-Null}
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{A8804298-2D5F-42E3-9531-9C8C39EB29CE}" "Value" "Deny"

# Other Devices: Don't let apps share and sync with non-explicitly-paired wireless devices over uPnP: Allow, Deny
# if (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\LooselyCoupled")) {New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\LooselyCoupled" -Type Folder | Out-Null}
# Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\LooselyCoupled" "Value" "Deny"

# Feedback: Windows should never ask for my feedback
if (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Siuf")) {New-Item -Path "HKCU:\SOFTWARE\Microsoft\Siuf" -Type Folder | Out-Null}
if (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Siuf\Rules")) {New-Item -Path "HKCU:\SOFTWARE\Microsoft\Siuf\Rules" -Type Folder | Out-Null}
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Siuf\Rules" "NumberOfSIUFInPeriod" 0

# Feedback: Telemetry: Send Diagnostic and usage data: Basic: 1, Enhanced: 2, Full: 3
Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" "AllowTelemetry" 1

###############################################################################
### Devices, Power, and Startup                                               #
###############################################################################
Write-Host "Configuring Devices, Power, and Startup..." -ForegroundColor "Yellow"

# Sound: Disable Startup Sound
# Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" "DisableStartupSound" 1
# Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI\BootAnimation" "DisableStartupSound" 1

# Power: Disable Hibernation
# powercfg /hibernate off

# Power: Set standby delay to 24 hours
# powercfg /change /standby-timeout-ac 1440

# SSD: Disable SuperFetch
# Set-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" "EnableSuperfetch" 0

# Network: Disable WiFi Sense
# Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config" "AutoConnectAllowedOEM" 0

###############################################################################
### Explorer, Taskbar, and System Tray                                        #
###############################################################################

# Taskbar: Disable Bing Search
# Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\ConnectedSearch" "ConnectedSearchUseWeb" 0 # For Windows 8.1
Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" "BingSearchEnabled" 0 # For Windows 10

###############################################################################
### Default Windows Applications                                              #
###############################################################################
Write-Host "Configuring Default Windows Applications..." -ForegroundColor "Yellow"

# Uninstall 3D Builder
Get-AppxPackage "Microsoft.3DBuilder" -AllUsers | Remove-AppxPackage
Get-AppXProvisionedPackage -Online | Where DisplayNam -like "Microsoft.3DBuilder" | Remove-AppxProvisionedPackage -Online

# Uninstall Alarms and Clock
Get-AppxPackage "Microsoft.WindowsAlarms" -AllUsers | Remove-AppxPackage
Get-AppXProvisionedPackage -Online | Where DisplayNam -like "Microsoft.WindowsAlarms" | Remove-AppxProvisionedPackage -Online

# Uninstall Autodesk Sketchbook
Get-AppxPackage "*.AutodeskSketchBook" -AllUsers | Remove-AppxPackage
Get-AppXProvisionedPackage -Online | Where DisplayNam -like "*.AutodeskSketchBook" | Remove-AppxProvisionedPackage -Online

# Uninstall Bing Finance
Get-AppxPackage "Microsoft.BingFinance" -AllUsers | Remove-AppxPackage
Get-AppXProvisionedPackage -Online | Where DisplayNam -like "Microsoft.BingFinance" | Remove-AppxProvisionedPackage -Online

# Uninstall Bing News
Get-AppxPackage "Microsoft.BingNews" -AllUsers | Remove-AppxPackage
Get-AppXProvisionedPackage -Online | Where DisplayNam -like "Microsoft.BingNews" | Remove-AppxProvisionedPackage -Online

# Uninstall Bing Sports
Get-AppxPackage "Microsoft.BingSports" -AllUsers | Remove-AppxPackage
Get-AppXProvisionedPackage -Online | Where DisplayNam -like "Microsoft.BingSports" | Remove-AppxProvisionedPackage -Online

# Uninstall Bing Weather
Get-AppxPackage "Microsoft.BingWeather" -AllUsers | Remove-AppxPackage
Get-AppXProvisionedPackage -Online | Where DisplayNam -like "Microsoft.BingWeather" | Remove-AppxProvisionedPackage -Online

# Uninstall Bubble Witch 3 Saga
Get-AppxPackage "king.com.BubbleWitch3Saga" -AllUsers | Remove-AppxPackage
Get-AppXProvisionedPackage -Online | Where DisplayNam -like "king.com.BubbleWitch3Saga" | Remove-AppxProvisionedPackage -Online

# Uninstall Calendar and Mail
# Get-AppxPackage "Microsoft.WindowsCommunicationsApps" -AllUsers | Remove-AppxPackage
# Get-AppXProvisionedPackage -Online | Where DisplayNam -like "Microsoft.WindowsCommunicationsApps" | Remove-AppxProvisionedPackage -Online

# Uninstall Candy Crush Soda Saga
Get-AppxPackage "king.com.CandyCrushSodaSaga" -AllUsers | Remove-AppxPackage
Get-AppXProvisionedPackage -Online | Where DisplayNam -like "king.com.CandyCrushSodaSaga" | Remove-AppxProvisionedPackage -Online

# Uninstall Disney Magic Kingdoms
Get-AppxPackage "*.DisneyMagicKingdoms" -AllUsers | Remove-AppxPackage
Get-AppXProvisionedPackage -Online | Where DisplayNam -like "*.DisneyMagicKingdoms" | Remove-AppxProvisionedPackage -Online

# Uninstall Dolby
# Get-AppxPackage "DolbyLaboratories.DolbyAccess" -AllUsers | Remove-AppxPackage
# Get-AppXProvisionedPackage -Online | Where DisplayNam -like "DolbyLaboratories.DolbyAccess" | Remove-AppxProvisionedPackage -Online

# Uninstall Facebook
Get-AppxPackage "*.Facebook" -AllUsers | Remove-AppxPackage
Get-AppXProvisionedPackage -Online | Where DisplayNam -like "*.Facebook" | Remove-AppxProvisionedPackage -Online

# Uninstall Get Office, and it's "Get Office365" notifications
Get-AppxPackage "Microsoft.MicrosoftOfficeHub" -AllUsers | Remove-AppxPackage
Get-AppXProvisionedPackage -Online | Where DisplayNam -like "Microsoft.MicrosoftOfficeHub" | Remove-AppxProvisionedPackage -Online

# Uninstall Get Started
Get-AppxPackage "Microsoft.GetStarted" -AllUsers | Remove-AppxPackage
Get-AppXProvisionedPackage -Online | Where DisplayNam -like "Microsoft.GetStarted" | Remove-AppxProvisionedPackage -Online

# Uninstall Maps
# Get-AppxPackage "Microsoft.WindowsMaps" -AllUsers | Remove-AppxPackage
# Get-AppXProvisionedPackage -Online | Where DisplayNam -like "Microsoft.WindowsMaps" | Remove-AppxProvisionedPackage -Online

# Uninstall March of Empires
Get-AppxPackage "*.MarchofEmpires" -AllUsers | Remove-AppxPackage
Get-AppXProvisionedPackage -Online | Where DisplayNam -like "*.MarchofEmpires" | Remove-AppxProvisionedPackage -Online

# Uninstall Messaging
Get-AppxPackage "Microsoft.Messaging" -AllUsers | Remove-AppxPackage
Get-AppXProvisionedPackage -Online | Where DisplayNam -like "Microsoft.Messaging" | Remove-AppxProvisionedPackage -Online

# Uninstall Mobile Plans
Get-AppxPackage "Microsoft.OneConnect" -AllUsers | Remove-AppxPackage
Get-AppXProvisionedPackage -Online | Where DisplayNam -like "Microsoft.OneConnect" | Remove-AppxProvisionedPackage -Online

# Uninstall OneNote
# Get-AppxPackage "Microsoft.Office.OneNote" -AllUsers | Remove-AppxPackage
# Get-AppXProvisionedPackage -Online | Where DisplayNam -like "Microsoft.Office.OneNote" | Remove-AppxProvisionedPackage -Online

# Uninstall Paint
# Get-AppxPackage "Microsoft.MSPaint" -AllUsers | Remove-AppxPackage
# Get-AppXProvisionedPackage -Online | Where DisplayNam -like "Microsoft.MSPaint" | Remove-AppxProvisionedPackage -Online

# Uninstall People
# Get-AppxPackage "Microsoft.People" -AllUsers | Remove-AppxPackage
# Get-AppXProvisionedPackage -Online | Where DisplayNam -like "Microsoft.People" | Remove-AppxProvisionedPackage -Online

# Uninstall Photos
# Get-AppxPackage "Microsoft.Windows.Photos" -AllUsers | Remove-AppxPackage
# Get-AppXProvisionedPackage -Online | Where DisplayNam -like "Microsoft.Windows.Photos" | Remove-AppxProvisionedPackage -Online

# Uninstall Print3D
# Get-AppxPackage "Microsoft.Print3D" -AllUsers | Remove-AppxPackage
# Get-AppXProvisionedPackage -Online | Where DisplayNam -like "Microsoft.Print3D" | Remove-AppxProvisionedPackage -Online

# Uninstall Skype
Get-AppxPackage "Microsoft.SkypeApp" -AllUsers | Remove-AppxPackage
Get-AppXProvisionedPackage -Online | Where DisplayNam -like "Microsoft.SkypeApp" | Remove-AppxProvisionedPackage -Online

# Uninstall SlingTV
Get-AppxPackage "*.SlingTV" -AllUsers | Remove-AppxPackage
Get-AppXProvisionedPackage -Online | Where DisplayNam -like "*.SlingTV" | Remove-AppxProvisionedPackage -Online

# Uninstall Solitaire
Get-AppxPackage "Microsoft.MicrosoftSolitaireCollection" -AllUsers | Remove-AppxPackage
Get-AppXProvisionedPackage -Online | Where DisplayNam -like "Microsoft.MicrosoftSolitaireCollection" | Remove-AppxProvisionedPackage -Online

# Uninstall Spotify
# Get-AppxPackage "SpotifyAB.SpotifyMusic" -AllUsers | Remove-AppxPackage
# Get-AppXProvisionedPackage -Online | Where DisplayNam -like "SpotifyAB.SpotifyMusic" | Remove-AppxProvisionedPackage -Online

# Uninstall StickyNotes
Get-AppxPackage "Microsoft.MicrosoftStickyNotes" -AllUsers | Remove-AppxPackage
Get-AppXProvisionedPackage -Online | Where DisplayNam -like "Microsoft.MicrosoftStickyNotes" | Remove-AppxProvisionedPackage -Online

# Uninstall Sway
Get-AppxPackage "Microsoft.Office.Sway" -AllUsers | Remove-AppxPackage
Get-AppXProvisionedPackage -Online | Where DisplayNam -like "Microsoft.Office.Sway" | Remove-AppxProvisionedPackage -Online

# Uninstall Twitter
Get-AppxPackage "*.Twitter" -AllUsers | Remove-AppxPackage
Get-AppXProvisionedPackage -Online | Where DisplayNam -like "*.Twitter" | Remove-AppxProvisionedPackage -Online

# Uninstall Voice Recorder
Get-AppxPackage "Microsoft.WindowsSoundRecorder" -AllUsers | Remove-AppxPackage
Get-AppXProvisionedPackage -Online | Where DisplayNam -like "Microsoft.WindowsSoundRecorder" | Remove-AppxProvisionedPackage -Online

# Uninstall Windows Phone Companion
# Get-AppxPackage "Microsoft.WindowsPhone" -AllUsers | Remove-AppxPackage
# Get-AppXProvisionedPackage -Online | Where DisplayNam -like "Microsoft.WindowsPhone" | Remove-AppxProvisionedPackage -Online

# Uninstall XBox
Get-AppxPackage "Microsoft.XboxApp" -AllUsers | Remove-AppxPackage
Get-AppXProvisionedPackage -Online | Where DisplayNam -like "Microsoft.XboxApp" | Remove-AppxProvisionedPackage -Online

# Uninstall Zune Music (Groove)
Get-AppxPackage "Microsoft.ZuneMusic" -AllUsers | Remove-AppxPackage
Get-AppXProvisionedPackage -Online | Where DisplayNam -like "Microsoft.ZuneMusic" | Remove-AppxProvisionedPackage -Online

# Uninstall Zune Video
Get-AppxPackage "Microsoft.ZuneVideo" -AllUsers | Remove-AppxPackage
Get-AppXProvisionedPackage -Online | Where DisplayNam -like "Microsoft.ZuneVideo" | Remove-AppxProvisionedPackage -Online

# Uninstall Windows Media Player
Disable-WindowsOptionalFeature -Online -FeatureName "WindowsMediaPlayer" -NoRestart -WarningAction SilentlyContinue | Out-Null

# Prevent "Suggested Applications" from returning
if (!(Test-Path "HKLM:\Software\Policies\Microsoft\Windows\CloudContent")) {New-Item -Path "HKLM:\Software\Policies\Microsoft\Windows\CloudContent" -Type Folder | Out-Null}
Set-ItemProperty "HKLM:\Software\Policies\Microsoft\Windows\CloudContent" "DisableWindowsConsumerFeatures" 1

###############################################################################
### Internet Explorer                                                         #
###############################################################################
Write-Host "Configuring Internet Explorer..." -ForegroundColor "Yellow"

# Set home page to `about:blank` for faster loading
Set-ItemProperty "HKCU:\Software\Microsoft\Internet Explorer\Main" "Start Page" "about:blank"

# Disable 'Default Browser' check: "yes" or "no"
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Internet Explorer\Main" "Check_Associations" "no"

# Disable Password Caching [Disable Remember Password]
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings" "DisablePasswordCaching" 1