if (![System.IO.File]::Exists("$env:UserProfile\Downloads\Browser\")) {
    New-Item -ItemType directory -Path $env:UserProfile\Downloads\Browser\
}

Add-Type -AssemblyName Microsoft.VisualBasic
[Microsoft.VisualBasic.FileIO.FileSystem]::Deletedirectory("$env:UserProfile\Downloads\Browser\", 'OnlyErrorDialogs', 'SendToRecycleBin')

New-Item -ItemType directory -Path $env:UserProfile\Downloads\Browser\