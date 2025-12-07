# Ensure script is running as administrator
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Start-Process powershell "-ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

# Set variables
$cttJsonUrl = "https://raw.githubusercontent.com/Haloman363/ctt/4ab068f00a27371cb6432639bd9b9831fa42a8b9/ctt-default.json"
$cttJsonPath = "$PSScriptRoot\ctt-default.json"

# Download the JSON file
Invoke-WebRequest -Uri $cttJsonUrl -OutFile $cttJsonPath

# Run the Chris Titus Toolkit with the config and -Run
Invoke-Expression "& { $(Invoke-RestMethod https://christitus.com/win) } -Config `"$cttJsonPath`" -Run"

# Clean up the JSON file
Remove-Item -Path $cttJsonPath -Force

exit
