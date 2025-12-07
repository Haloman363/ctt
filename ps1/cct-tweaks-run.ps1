# Ensure script is running as administrator
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Start-Process powershell "-ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

# Set variables
$cttJsonUrl = "https://raw.githubusercontent.com/Haloman363/ctt/refs/heads/main/json/ctt-tweaks.json"
$cttJsonPath = "$PSScriptRoot\ctt-tweaks.json"

# Download the JSON file
Invoke-WebRequest -Uri $cttJsonUrl -OutFile $cttJsonPath

# Run the Chris Titus Toolkit with the config and -Run
Invoke-Expression "& { $(Invoke-RestMethod https://christitus.com/win) } -Config `"$cttJsonPath`" -Run"

# Clean up the JSON file
Remove-Item -Path $cttJsonPath -Force

exit
