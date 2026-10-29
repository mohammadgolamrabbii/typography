<#
==============================================================================
 Open Typography Foundation — Universal Windows PowerShell Font Installer
 Curated by Mohammad Golamrabbii
 Zero Rate-Limits, Full High-Speed Mirroring, System-Wide Registration
==============================================================================
#>

[CmdletBinding()]
param (
    [Parameter(Position = 0)]
    [ValidateSet("Bengali", "Cyrillic", "Japanese", "English", "Arabic", "Hindi", "German", "All", "Menu")]
    [string]$Language = "Menu"
)

$ErrorActionPreference = "Stop"

Write-Host ""
Write-Host "  ___                      _____                                     _           " -ForegroundColor Cyan
Write-Host " / _ \ _ __   ___ _ __    |_   _|   _ _ __   ___   __ _ _ __ __ _ _ __ | |__  _   _ " -ForegroundColor Cyan
Write-Host "| | | | '_ \ / _ \ '_ \     | || | | | '_ \ / _ \ / _` | '__/ _` | '_ \| '_ \| | | |" -ForegroundColor Cyan
Write-Host "| |_| | |_) |  __/ | | |    | || |_| | |_) | (_) | (_| | | | (_| | |_) | | | | |_| |" -ForegroundColor Cyan
Write-Host " \___/| .__/ \___|_| |_|    |_| \__, | .__/ \___/ \__, |_|  \__,_| .__/|_| |_|\__, |" -ForegroundColor Cyan
Write-Host "      |_|                       |___/|_|          |___/          |_|          |___/ " -ForegroundColor Cyan
Write-Host "  Curated by Mohammad Golamrabbii • Open Typography Foundation" -ForegroundColor Yellow
Write-Host "  Permanent High-Speed GitHub & Internet Archive Windows Installer" -ForegroundColor Green
Write-Host "==============================================================================" -ForegroundColor Gray

$UserFontDir = [System.IO.Path]::Combine($env:LOCALAPPDATA, "Microsoft\Windows\Fonts")
if (-not (Test-Path $UserFontDir)) {
    New-Item -ItemType Directory -Force -Path $UserFontDir | Out-Null
}

$RegistryPath = "HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Fonts"

$Repos = @{
    "Bengali"  = "https://github.com/mohammadgolamrabbii/Bangla-Fonts-Mega-Collection.git"
    "Cyrillic" = "https://github.com/mohammadgolamrabbii/Cyrillic-Slavic-Mega-Archive.git"
    "Japanese" = "https://github.com/mohammadgolamrabbii/Japanese-Fonts-Mega-Archive.git"
    "English"  = "https://github.com/mohammadgolamrabbii/English-Latin-Fonts-Archive.git"
    "Arabic"   = "https://github.com/mohammadgolamrabbii/Arabic-Islamic-Fonts-Archive.git"
    "Hindi"    = "https://github.com/mohammadgolamrabbii/Hindi-Devanagari-Fonts-Archive.git"
    "German"   = "https://github.com/mohammadgolamrabbii/German-Fraktur-Fonts-Archive.git"
}

function Install-FontFamily {
    param ([string]$Lang)
    
    $repoUrl = $Repos[$Lang]
    if (-not $repoUrl) { return }
    
    $tempClone = [System.IO.Path]::Combine($env:TEMP, "OTF_Install_$Lang")
    Write-Host "`n>>> Ingesting $Lang Typography Archive..." -ForegroundColor Yellow
    
    if (Test-Path $tempClone) {
        Remove-Item -Recurse -Force $tempClone -ErrorAction SilentlyContinue
    }
    
    Write-Host "[*] Fetching shallow git mirror ($repoUrl)..." -ForegroundColor Cyan
    git clone --depth 1 $repoUrl $tempClone
    
    $fontFiles = Get-ChildItem -Path $tempClone -Recurse -Include *.ttf, *.otf, *.ttc
    Write-Host "[*] Registering $($fontFiles.Count) $Lang fonts in Windows Registry..." -ForegroundColor Cyan
    
    $installed = 0
    foreach ($file in $fontFiles) {
        $targetPath = [System.IO.Path]::Combine($UserFontDir, $file.Name)
        Copy-Item -Path $file.FullName -Destination $targetPath -Force
        
        $fontName = [System.IO.Path]::GetFileNameWithoutExtension($file.Name)
        if ($file.Extension -eq ".otf") {
            $regName = "$fontName (OpenType)"
        } else {
            $regName = "$fontName (TrueType)"
        }
        
        Set-ItemProperty -Path $RegistryPath -Name $regName -Value $targetPath -ErrorAction SilentlyContinue
        $installed++
    }
    
    Remove-Item -Recurse -Force $tempClone -ErrorAction SilentlyContinue
    Write-Host "[✔] Successfully installed and registered $installed $Lang fonts!" -ForegroundColor Green
}

function Broadcast-FontChange {
    Write-Host "`n[*] Broadcasting Windows WM_FONTCHANGE notification..." -ForegroundColor Cyan
    $CSharpCode = @"
    using System;
    using System.Runtime.InteropServices;
    public class FontBroadcaster {
        [DllImport("user32.dll", SetLastError = true, CharSet = CharSet.Auto)]
        public static extern IntPtr SendMessageTimeout(IntPtr hWnd, uint Msg, UIntPtr wParam, string lParam, uint fuFlags, uint uTimeout, out UIntPtr lpdwResult);
    }
"@
    Add-Type -TypeDefinition $CSharpCode -ErrorAction SilentlyContinue
    $HWND_BROADCAST = [IntPtr]0xffff
    $WM_FONTCHANGE = 0x001D
    $SMTO_ABORTIFHUNG = 0x0002
    $result = [UIntPtr]::Zero
    [FontBroadcaster]::SendMessageTimeout($HWND_BROADCAST, $WM_FONTCHANGE, [UIntPtr]::Zero, $null, $SMTO_ABORTIFHUNG, 1000, [ref]$result) | Out-Null
    Write-Host "[✔] Windows Font Registry updated across Photoshop, Illustrator, Word, Figma, and all apps!" -ForegroundColor Green
}

if ($Language -eq "Menu") {
    Write-Host "`nSelect typography archive to install:" -ForegroundColor White
    Write-Host " 1) 🇧🇩 Bengali (3,400+ Fonts)"
    Write-Host " 2) 🇷🇺 Cyrillic & Slavic (10,136 Fonts)"
    Write-Host " 3) 🇯🇵 Japanese / Nihongo (1,100+ Fonts)"
    Write-Host " 4) 🇬🇧 English & Latin (30,800+ Fonts)"
    Write-Host " 5) 🕌 Arabic & Islamic (13,800+ Fonts)"
    Write-Host " 6) 🇮🇳 Hindi & Devanagari (6,000+ Fonts)"
    Write-Host " 7) 🇩🇪 German Fraktur (5,400+ Fonts)"
    Write-Host " 8) 🌐 Install ALL Curated Collections (70,000+ Fonts)"
    Write-Host " 0) Exit"
    $choice = Read-Host "`nEnter choice [1-8]"
    
    switch ($choice) {
        "1" { Install-FontFamily "Bengali" }
        "2" { Install-FontFamily "Cyrillic" }
        "3" { Install-FontFamily "Japanese" }
        "4" { Install-FontFamily "English" }
        "5" { Install-FontFamily "Arabic" }
        "6" { Install-FontFamily "Hindi" }
        "7" { Install-FontFamily "German" }
        "8" { @("Bengali", "Cyrillic", "Japanese", "English", "Arabic", "Hindi", "German") | ForEach-Object { Install-FontFamily $_ } }
        Default { Write-Host "Exited."; exit }
    }
} elseif ($Language -eq "All") {
    @("Bengali", "Cyrillic", "Japanese", "English", "Arabic", "Hindi", "German") | ForEach-Object { Install-FontFamily $_ }
} else {
    Install-FontFamily $Language
}

Broadcast-FontChange

Write-Host "`n==============================================================================" -ForegroundColor Green
Write-Host "  INSTALLATION COMPLETE! ALL FONTS READY ACROSS WINDOWS." -ForegroundColor Green
Write-Host "  Curated by Mohammad Golamrabbii for the Open Typography Foundation." -ForegroundColor Yellow
Write-Host "==============================================================================`n" -ForegroundColor Green
