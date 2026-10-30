<#
==============================================================================
 Open Typography Foundation — Universal Windows PowerShell Font Installer
 Curated by Mohammad Golamrabbii
 Zero Rate-Limits, Full High-Speed Mirroring, System-Wide Registration (80,000+ Fonts)
==============================================================================
#>

[CmdletBinding()]
param (
    [Parameter(Position = 0)]
    [ValidateSet("Bengali", "English", "Arabic", "Cyrillic", "Hindi", "German", "Korean", "Japanese", "Chinese", "Icons", "Vietnamese", "Thai", "Malay", "Dev", "Dravidian", "African", "Urdu", "All", "Menu")]
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
Write-Host "  Permanent High-Speed GitHub & Internet Archive Windows Installer (80,000+ Production Fonts)" -ForegroundColor Green
Write-Host "==============================================================================" -ForegroundColor Gray

$UserFontDir = [System.IO.Path]::Combine($env:LOCALAPPDATA, "Microsoft\Windows\Fonts")
if (-not (Test-Path $UserFontDir)) {
    New-Item -ItemType Directory -Force -Path $UserFontDir | Out-Null
}

$RegistryPath = "HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Fonts"

$Repos = @{
    "Bengali"  = "https://github.com/mohammadgolamrabbii/Bangla-Fonts-Mega-Collection.git"
    "English"  = "https://github.com/mohammadgolamrabbii/English-Fonts-Mega-Archive.git"
    "Arabic"   = "https://github.com/mohammadgolamrabbii/Arabic-Fonts-Mega-Archive.git"
    "Cyrillic" = "https://github.com/mohammadgolamrabbii/Cyrillic-Fonts-Mega-Archive.git"
    "Hindi"    = "https://github.com/mohammadgolamrabbii/Hindi-Fonts-Mega-Archive.git"
    "German"   = "https://github.com/mohammadgolamrabbii/German-Fonts-Mega-Archive.git"
    "Korean"   = "https://github.com/mohammadgolamrabbii/Korean-Hangul-Fonts-Archive.git"
    "Japanese" = "https://github.com/mohammadgolamrabbii/Japanese-Fonts-Mega-Archive.git"
    "Chinese"  = "https://github.com/Open-Typography-Foundation/Chinese-Hanzi-Fonts-Archive.git"
    "Icons"    = "https://github.com/Open-Typography-Foundation/Icons-and-Symbols-Fonts.git"
    "Vietnamese" = "https://github.com/Open-Typography-Foundation/Vietnamese-Fonts-Mega-Archive.git"
    "Thai"       = "https://github.com/Open-Typography-Foundation/Thai-Fonts-Mega-Archive.git"
    "Malay"      = "https://github.com/Open-Typography-Foundation/Malay-Nusantara-Fonts-Archive.git"
    "Dev"        = "https://github.com/Open-Typography-Foundation/Developer-Coding-Fonts-Archive.git"
    "Dravidian"  = "https://github.com/Open-Typography-Foundation/Dravidian-Fonts-Mega-Archive.git"
    "African"    = "https://github.com/Open-Typography-Foundation/African-Scripts-Mega-Archive.git"
    "Urdu"       = "https://github.com/Open-Typography-Foundation/Persian-Urdu-Nastaliq-Fonts-Archive.git"
}

$ArchiveZips = @{
    "Bengali"  = "https://archive.org/download/open-typography-foundation-bangla-fonts/Bangla_Fonts_Mega_Collection_5000_Fonts.zip"
    "Cyrillic" = "https://archive.org/download/open-typography-foundation-cyrillic-slavic/Cyrillic_Slavic_Mega_Archive_10136_Fonts.zip"
    "Japanese" = "https://archive.org/download/open-typography-foundation-japanese-fonts/Japanese_Fonts_Mega_Archive_1500_Fonts.zip"
    "Hindi"    = "https://archive.org/download/open-typography-foundation-hindi-fonts/Hindi_Devanagari_Fonts_Archive.zip"
    "German"   = "https://archive.org/download/open-typography-foundation-german-fonts/German_Fraktur_Fonts_Archive.zip"
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

$AllLanguages = @("Bengali", "English", "Arabic", "Cyrillic", "Hindi", "German", "Korean", "Japanese", "Chinese", "Icons")

if ($Language -eq "Menu") {
    Write-Host "`nSelect typography archive to install:" -ForegroundColor White
    Write-Host "  1) 🇧🇩 Bengali (5,020+ Fonts)"
    Write-Host "  2) 🇬🇧 English & Latin (30,930+ Fonts)"
    Write-Host "  3) 🕌 Arabic & Islamic (13,856+ Fonts)"
    Write-Host "  4) 🇷🇺 Cyrillic & Slavic (10,136+ Fonts)"
    Write-Host "  5) 🇮🇳 Hindi & Devanagari (6,519+ Fonts)"
    Write-Host "  6) 🇩🇪 German Deutsche Schriften (5,504+ Fonts)"
    Write-Host "  7) 🇰🇷 Korean Hangul (1,863+ Fonts)"
    Write-Host "  8) 🇯🇵 Japanese Nihongo (1,509+ Fonts)"
    Write-Host "  9) 🇨🇳 Chinese Hanzi (1,350+ Fonts)"
    Write-Host " 10) 🎨 Icons & Symbols (1,177+ Fonts)"
    Write-Host " 11) 🌐 Install ALL Global Collections (80,000+ Fonts)"
    Write-Host "  0) Exit"
    $choice = Read-Host "`nEnter choice [1-11]"
    
    switch ($choice) {
        "1" { Install-FontFamily "Bengali" }
        "2" { Install-FontFamily "English" }
        "3" { Install-FontFamily "Arabic" }
        "4" { Install-FontFamily "Cyrillic" }
        "5" { Install-FontFamily "Hindi" }
        "6" { Install-FontFamily "German" }
        "7" { Install-FontFamily "Korean" }
        "8" { Install-FontFamily "Japanese" }
        "9" { Install-FontFamily "Chinese" }
        "10" { Install-FontFamily "Icons" }
        "11" { $AllLanguages | ForEach-Object { Install-FontFamily $_ } }
        Default { Write-Host "Exited."; exit }
    }
} elseif ($Language -eq "All") {
    $AllLanguages | ForEach-Object { Install-FontFamily $_ }
} else {
    Install-FontFamily $Language
}

Broadcast-FontChange

Write-Host "`n==============================================================================" -ForegroundColor Green
Write-Host "  INSTALLATION COMPLETE! ALL FONTS READY ACROSS WINDOWS." -ForegroundColor Green
Write-Host "  Curated by Mohammad Golamrabbii for the Open Typography Foundation." -ForegroundColor Yellow
Write-Host "==============================================================================`n" -ForegroundColor Green
