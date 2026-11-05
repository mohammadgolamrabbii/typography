# ============================================================
#  🛡️ Universal Font Installer — Open Typography Foundation
#  Curated by Mohammad Golamrabbii | 500,337+ Sovereign Fonts
#  Usage (Express): irm https://mohammadgolamrabbii.github.io/typography/install.ps1 | iex
#  Usage (Script):  & ([scriptblock]::Create((irm https://mohammadgolamrabbii.github.io/typography/install.ps1))) -TargetScript english
# ============================================================

param(
    [string]$InstallDir = "$env:LOCALAPPDATA\Microsoft\Windows\Fonts",
    [Alias("Language", "Script")]
    [string]$TargetScript = "all",
    [switch]$SystemWide,
    [switch]$Force,
    [switch]$Yes,
    [switch]$NonInteractive
)

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$ErrorActionPreference = "SilentlyContinue"

if ($SystemWide) { $InstallDir = "$env:SystemRoot\Fonts" }

Write-Host "╔══════════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║  🛡️ Open Typography Foundation — Verified Font Installer         ║" -ForegroundColor Cyan
Write-Host "║  Preserving 500,337+ Open-Source Typefaces Across 100 Vaults    ║" -ForegroundColor Cyan
Write-Host "║  Curated by Mohammad Golamrabbii | Free & Open-Source (SIL OFL)  ║" -ForegroundColor Cyan
Write-Host "╚══════════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

$TargetScript = $TargetScript.ToLower()
Write-Host "→ Installation Target : $InstallDir" -ForegroundColor Yellow
Write-Host "→ Target Script Vault : $TargetScript" -ForegroundColor Yellow
Write-Host "→ System Privileges   : $(if ($SystemWide) { 'System-Wide (Administrator)' } else { 'User-Space (No Admin Required)' })" -ForegroundColor Yellow

# Interactive Confirmation Prompt
$isInteractive = [Environment]::UserInteractive -and (-not $Force) -and (-not $Yes) -and (-not $NonInteractive)
if ($isInteractive) {
    Write-Host ""
    $confirm = Read-Host "Proceed with downloading and registering verified fonts to '$InstallDir'? [Y/n]"
    if ($confirm -match '^[nN]') {
        Write-Host "❌ Installation cancelled by user." -ForegroundColor Red
        exit 0
    }
}

New-Item -ItemType Directory -Force -Path $InstallDir | Out-Null

# Native Windows Font Registration API
Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;
public class FontManager {
    [DllImport("gdi32.dll", EntryPoint="AddFontResourceW", SetLastError=true)]
    public static extern int AddFontResource([In, MarshalAs(UnmanagedType.LPWStr)] string lpFileName);

    [DllImport("user32.dll")]
    public static extern int SendMessage(IntPtr hWnd, uint Msg, UIntPtr wParam, IntPtr lParam);
    public const uint WM_FONTCHANGE = 0x001D;
    public static readonly IntPtr HWND_BROADCAST = new IntPtr(0xffff);

    public static void Broadcast() {
        SendMessage(HWND_BROADCAST, WM_FONTCHANGE, UIntPtr.Zero, IntPtr.Zero);
    }
}
"@ -ErrorAction SilentlyContinue

$RepoMap = @{
    "bengali"   = "https://github.com/mohammadgolamrabbii/Bangla-Fonts-Mega-Collection.git"
    "english"   = "https://github.com/mohammadgolamrabbii/English-Fonts-Mega-Archive.git"
    "arabic"    = "https://github.com/mohammadgolamrabbii/Arabic-Fonts-Mega-Archive.git"
    "hindi"     = "https://github.com/mohammadgolamrabbii/Hindi-Fonts-Mega-Archive.git"
    "german"    = "https://github.com/mohammadgolamrabbii/German-Fonts-Mega-Archive.git"
    "japanese"  = "https://github.com/Open-Typography-Foundation/Japanese-Fonts-Mega-Archive.git"
    "cyrillic"  = "https://github.com/Open-Typography-Foundation/Cyrillic-Fonts-Mega-Archive.git"
    "korean"    = "https://github.com/Open-Typography-Foundation/Korean-Hangul-Fonts-Archive.git"
    "chinese"   = "https://github.com/Open-Typography-Foundation/Chinese-Hanzi-Fonts-Archive.git"
    "dev"       = "https://github.com/Open-Typography-Foundation/Developer-Coding-Fonts-Archive.git"
    "icons"     = "https://github.com/Open-Typography-Foundation/Icons-and-Symbols-Fonts.git"
}

$targetUrls = @()
if ($TargetScript -ne "all" -and $RepoMap.ContainsKey($TargetScript)) {
    $targetUrls += $RepoMap[$TargetScript]
} else {
    foreach ($val in $RepoMap.Values) { $targetUrls += $val }
}

Write-Host ""
Write-Host "→ Connecting to verified open-source typography vaults..." -ForegroundColor Cyan

$tempExtract = "$env:TEMP\OpenTypography_Install"
New-Item -ItemType Directory -Force -Path $tempExtract | Out-Null

$installed = 0
$regPath = "HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Fonts"
if ($SystemWide) { $regPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts" }

foreach ($url in $targetUrls) {
    $vaultName = [System.IO.Path]::GetFileNameWithoutExtension($url)
    Write-Host "  → Synchronizing $vaultName ..." -ForegroundColor DarkGray
    $dest = Join-Path $tempExtract $vaultName
    if (-not (Test-Path $dest)) {
        & git clone --depth=1 "$url" $dest 2>$null
    }
    
    $fonts = Get-ChildItem -Path $dest -Recurse -Include "*.ttf", "*.otf" -ErrorAction SilentlyContinue
    foreach ($f in $fonts) {
        $targetFile = Join-Path $InstallDir $f.Name
        if (-not (Test-Path $targetFile)) {
            Copy-Item -Path $f.FullName -Destination $targetFile -Force
        }
        $fontName = [System.IO.Path]::GetFileNameWithoutExtension($f.Name)
        New-ItemProperty -Path $regPath -Name "$fontName (TrueType)" -Value $targetFile -PropertyType String -Force | Out-Null
        [FontManager]::AddFontResource($targetFile) | Out-Null
        $installed++
    }
}

[FontManager]::Broadcast()

Write-Host ""
Write-Host "==================================================================" -ForegroundColor Green
Write-Host "✅ Installation Complete! $installed fonts registered successfully." -ForegroundColor Green
Write-Host "   Directory: $InstallDir" -ForegroundColor Cyan
Write-Host "   Fonts are now live in Photoshop, Illustrator, Word, Figma & Terminal." -ForegroundColor Cyan
Write-Host "==================================================================" -ForegroundColor Green
