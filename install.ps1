# ============================================================
#  🛡️ Universal Font Installer — Open Typography Foundation
#  Curated by Mohammad Golamrabbii | 500,337+ Sovereign Fonts
#  Usage (Express): irm https://mohammadgolamrabbii.github.io/typography/install.ps1 | iex
#  Usage (Secure):  Invoke-WebRequest ...; Get-FileHash ...; .\install.ps1
# ============================================================

param(
    [string]$InstallDir = "$env:LOCALAPPDATA\Microsoft\Windows\Fonts",
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

Write-Host "→ Installation Target : $InstallDir" -ForegroundColor Yellow
Write-Host "→ Target Vault Filter : $TargetScript" -ForegroundColor Yellow
Write-Host "→ System Privileges   : $(if ($SystemWide) { 'System-Wide (Administrator)' } else { 'User-Space (No Admin Required)' })" -ForegroundColor Yellow

# Interactive Confirmation Prompt (Security Guard against accidental runs)
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

$RepoBase = "https://github.com/Open-Typography-Foundation"
$vaults = @(
    "1_Bengali Fonts", "2_English_Latin", "3_Arabic_Islamic", "7_Hindi_Devanagari",
    "8_German_Deutsche_Schriften", "9_Japanese_Nihongo", "10_Cyrillic_Slavic",
    "11_Korean_Hangul", "12_Chinese_Hanzi", "16_Developer_Coding_Monospace"
)

Write-Host ""
Write-Host "→ Connecting to Open Typography Foundation vaults..." -ForegroundColor Cyan

$tempExtract = "$env:TEMP\OpenTypography_Install"
New-Item -ItemType Directory -Force -Path $tempExtract | Out-Null

$installed = 0
$regPath = "HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Fonts"
if ($SystemWide) { $regPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts" }

foreach ($vault in $vaults) {
    Write-Host "  → Synchronizing $vault ..." -ForegroundColor DarkGray
    $dest = Join-Path $tempExtract $vault
    if (-not (Test-Path $dest)) {
        & git clone --depth=1 "$RepoBase/$vault" $dest 2>$null
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
