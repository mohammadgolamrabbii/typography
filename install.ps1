# Open Typography Foundation - Universal Windows Font Fast-Installer
# Curated by Mohammad Golamrabbii (100% Free Public Heritage)
param(
    [string]$Script = "all"
)
$ErrorActionPreference = "SilentlyContinue"
Write-Host "🏛️ Open Typography Foundation — Windows Font Engine" -ForegroundColor Cyan
Write-Host "Curated by Mohammad Golamrabbii (79 Sovereign Mega-Vaults • 95,000+ Fonts • 100% Free)" -ForegroundColor Yellow

$FontsFolder = [System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::Fonts)
$TempDir = Join-Path $env:TEMP "OpenTypography"
New-Item -ItemType Directory -Path $TempDir -Force | Out-Null

$Repos = @{
    "bangla-mega-collection" = "https://github.com/Open-Typography-Foundation/Bangla-Fonts-Mega-Collection.git"
    "english-latin" = "https://github.com/Open-Typography-Foundation/English-Latin-Fonts-Archive.git"
    "arabic-islamic" = "https://github.com/Open-Typography-Foundation/Arabic-Islamic-Fonts-Archive.git"
    "icons-and-symbols" = "https://github.com/Open-Typography-Foundation/Icons-and-Symbols-Fonts.git"
    "legacy" = "https://github.com/Open-Typography-Foundation/Legacy-Archive-Fonts.git"
    "world-languages" = "https://github.com/Open-Typography-Foundation/World-Languages-Fonts.git"
    "hindi-devanagari" = "https://github.com/Open-Typography-Foundation/Hindi-Devanagari-Fonts-Archive.git"
    "8_german_deutsche_schriften" = "https://github.com/Open-Typography-Foundation/8_German_Deutsche_Schriften.git"
    "japanese-mega" = "https://github.com/Open-Typography-Foundation/Japanese-Fonts-Mega-Archive.git"
    "cyrillic-slavic-mega" = "https://github.com/Open-Typography-Foundation/Cyrillic-Slavic-Mega-Archive.git"
    "korean-hangul" = "https://github.com/Open-Typography-Foundation/Korean-Hangul-Fonts-Archive.git"
    "chinese-hanzi" = "https://github.com/Open-Typography-Foundation/Chinese-Hanzi-Fonts-Archive.git"
    "vietnamese-mega" = "https://github.com/Open-Typography-Foundation/Vietnamese-Fonts-Mega-Archive.git"
    "thai-siam-mega" = "https://github.com/Open-Typography-Foundation/Thai-Siam-Fonts-Mega-Archive.git"
    "malay-nusantara" = "https://github.com/Open-Typography-Foundation/Malay-Nusantara-Fonts-Archive.git"
    "developer-coding-monospace" = "https://github.com/Open-Typography-Foundation/Developer-Coding-Monospace-Fonts-Archive.git"
    "dravidian-mega" = "https://github.com/Open-Typography-Foundation/Dravidian-Fonts-Mega-Archive.git"
    "african-scripts-mega" = "https://github.com/Open-Typography-Foundation/African-Scripts-Mega-Archive.git"
    "persian-urdu-nastaliq" = "https://github.com/Open-Typography-Foundation/Persian-Urdu-Nastaliq-Fonts-Archive.git"
    "hebrew-mega" = "https://github.com/Open-Typography-Foundation/Hebrew-Fonts-Mega-Archive.git"
    "greek-hellenic" = "https://github.com/Open-Typography-Foundation/Greek-Hellenic-Fonts-Archive.git"
    "khmer-cambodian" = "https://github.com/Open-Typography-Foundation/Khmer-Cambodian-Fonts-Archive.git"
    "myanmar-burmese" = "https://github.com/Open-Typography-Foundation/Myanmar-Burmese-Fonts-Archive.git"
    "sinhala-srilankan" = "https://github.com/Open-Typography-Foundation/Sinhala-SriLankan-Fonts-Archive.git"
    "lao-lanxang" = "https://github.com/Open-Typography-Foundation/Lao-LanXang-Fonts-Archive.git"
    "tibetan-himalayan" = "https://github.com/Open-Typography-Foundation/Tibetan-Himalayan-Fonts-Archive.git"
    "georgian-kartvelian" = "https://github.com/Open-Typography-Foundation/Georgian-Kartvelian-Fonts-Archive.git"
    "armenian-haykakan" = "https://github.com/Open-Typography-Foundation/Armenian-Haykakan-Fonts-Archive.git"
    "mongolian-nomadic" = "https://github.com/Open-Typography-Foundation/Mongolian-Nomadic-Fonts-Archive.git"
    "javanese-aksarajawa" = "https://github.com/Open-Typography-Foundation/Javanese-AksaraJawa-Fonts-Archive.git"
    "sundanese-aksarasunda" = "https://github.com/Open-Typography-Foundation/Sundanese-AksaraSunda-Fonts-Archive.git"
    "balinese-aksarabali" = "https://github.com/Open-Typography-Foundation/Balinese-AksaraBali-Fonts-Archive.git"
    "batak-suratbatak" = "https://github.com/Open-Typography-Foundation/Batak-SuratBatak-Fonts-Archive.git"
    "buginese-lontara" = "https://github.com/Open-Typography-Foundation/Buginese-Lontara-Fonts-Archive.git"
    "tagalog-baybayin" = "https://github.com/Open-Typography-Foundation/Tagalog-Baybayin-Fonts-Archive.git"
    "thaana-dhivehi" = "https://github.com/Open-Typography-Foundation/Thaana-Dhivehi-Fonts-Archive.git"
    "chakma-changma" = "https://github.com/Open-Typography-Foundation/Chakma-Changma-Fonts-Archive.git"
    "sylheti-nagri" = "https://github.com/Open-Typography-Foundation/Sylheti-Nagri-Fonts-Archive.git"
    "meetei-mayek" = "https://github.com/Open-Typography-Foundation/Meetei-Mayek-Fonts-Archive.git"
    "odia-oriya" = "https://github.com/Open-Typography-Foundation/Odia-Oriya-Fonts-Archive.git"
    "gujarati-gurjar" = "https://github.com/Open-Typography-Foundation/Gujarati-Gurjar-Fonts-Archive.git"
    "gurmukhi-punjabi" = "https://github.com/Open-Typography-Foundation/Gurmukhi-Punjabi-Fonts-Archive.git"
    "assamese-axomiya" = "https://github.com/Open-Typography-Foundation/Assamese-Axomiya-Fonts-Archive.git"
    "santali-olchiki" = "https://github.com/Open-Typography-Foundation/Santali-OlChiki-Fonts-Archive.git"
    "sora-sompeng" = "https://github.com/Open-Typography-Foundation/Sora-Sompeng-Fonts-Archive.git"
    "lepcha-rong" = "https://github.com/Open-Typography-Foundation/Lepcha-Rong-Fonts-Archive.git"
    "limbu-sirijonga" = "https://github.com/Open-Typography-Foundation/Limbu-Sirijonga-Fonts-Archive.git"
    "newa-prachalit" = "https://github.com/Open-Typography-Foundation/Newa-Prachalit-Fonts-Archive.git"
    "tirhuta-mithilakshar" = "https://github.com/Open-Typography-Foundation/Tirhuta-Mithilakshar-Fonts-Archive.git"
    "syriac-aramaic" = "https://github.com/Open-Typography-Foundation/Syriac-Aramaic-Fonts-Archive.git"
    "coptic-bohairic" = "https://github.com/Open-Typography-Foundation/Coptic-Bohairic-Fonts-Archive.git"
    "tifinagh-amazigh" = "https://github.com/Open-Typography-Foundation/Tifinagh-Amazigh-Fonts-Archive.git"
    "nko-manding" = "https://github.com/Open-Typography-Foundation/NKo-Manding-Fonts-Archive.git"
    "vai-liberian" = "https://github.com/Open-Typography-Foundation/Vai-Liberian-Fonts-Archive.git"
    "adlam-fulani" = "https://github.com/Open-Typography-Foundation/Adlam-Fulani-Fonts-Archive.git"
    "osmanya-somali" = "https://github.com/Open-Typography-Foundation/Osmanya-Somali-Fonts-Archive.git"
    "cherokee-tsalagi" = "https://github.com/Open-Typography-Foundation/Cherokee-Tsalagi-Fonts-Archive.git"
    "canadian-aboriginal" = "https://github.com/Open-Typography-Foundation/Canadian-Aboriginal-Fonts-Archive.git"
    "runic-glagolitic" = "https://github.com/Open-Typography-Foundation/Runic-Glagolitic-Fonts-Archive.git"
    "gothic-ancient" = "https://github.com/Open-Typography-Foundation/Gothic-Ancient-Fonts-Archive.git"
    "ogham-celtic" = "https://github.com/Open-Typography-Foundation/Ogham-Celtic-Fonts-Archive.git"
    "old-permic-abur" = "https://github.com/Open-Typography-Foundation/Old-Permic-Abur-Fonts-Archive.git"
    "old-turkic-orkhon" = "https://github.com/Open-Typography-Foundation/Old-Turkic-Orkhon-Fonts-Archive.git"
    "old-hungarian-rovas" = "https://github.com/Open-Typography-Foundation/Old-Hungarian-Rovas-Fonts-Archive.git"
    "south-arabian-musnad" = "https://github.com/Open-Typography-Foundation/South-Arabian-Musnad-Fonts-Archive.git"
    "phoenician-archaic" = "https://github.com/Open-Typography-Foundation/Phoenician-Archaic-Fonts-Archive.git"
    "avestan-pahlavi" = "https://github.com/Open-Typography-Foundation/Avestan-Pahlavi-Fonts-Archive.git"
    "kharosthi-gandhara" = "https://github.com/Open-Typography-Foundation/Kharosthi-Gandhara-Fonts-Archive.git"
    "brahmi-ashokan" = "https://github.com/Open-Typography-Foundation/Brahmi-Ashokan-Fonts-Archive.git"
    "cuneiform-mesopotamian" = "https://github.com/Open-Typography-Foundation/Cuneiform-Mesopotamian-Fonts-Archive.git"
    "egyptian-hieroglyphs" = "https://github.com/Open-Typography-Foundation/Egyptian-Hieroglyphs-Fonts-Archive.git"
    "linear-a-b-mycenaean" = "https://github.com/Open-Typography-Foundation/Linear-A-B-Mycenaean-Fonts-Archive.git"
    "tangut-western-xia" = "https://github.com/Open-Typography-Foundation/Tangut-Western-Xia-Fonts-Archive.git"
    "nushu-women-script" = "https://github.com/Open-Typography-Foundation/Nushu-Women-Script-Fonts-Archive.git"
    "bassa-vah-liberian" = "https://github.com/Open-Typography-Foundation/Bassa-Vah-Liberian-Fonts-Archive.git"
    "medefaidrin-nigerian" = "https://github.com/Open-Typography-Foundation/Medefaidrin-Nigerian-Fonts-Archive.git"
    "mandaic-gnostic" = "https://github.com/Open-Typography-Foundation/Mandaic-Gnostic-Fonts-Archive.git"
    "samaritan-hebrew" = "https://github.com/Open-Typography-Foundation/Samaritan-Hebrew-Fonts-Archive.git"
    "hanifi-rohingya" = "https://github.com/Open-Typography-Foundation/Hanifi-Rohingya-Fonts-Archive.git"
}

function Install-VaultFonts($name, $url) {
    Write-Host "[*] Mirroring vault: $name..." -ForegroundColor Cyan
    $vPath = Join-Path $TempDir $name
    if (-not (Test-Path $vPath)) {
        git clone --depth 1 --quiet $url $vPath
    }
    $fonts = Get-ChildItem -Path $vPath -Include "*.ttf", "*.otf" -Recurse
    $count = 0
    foreach ($f in $fonts) {
        $target = Join-Path $FontsFolder $f.Name
        if (-not (Test-Path $target)) {
            Copy-Item -Path $f.FullName -Destination $target -Force
            New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts" -Name $f.Name -Value $f.Name -PropertyType String -Force | Out-Null
            $count++
        }
    }
    Write-Host "  [✓] Installed $count new fonts from $name!" -ForegroundColor Green
}

if ($Script -eq "all") {
    foreach ($k in $Repos.Keys) {
        Install-VaultFonts $k $Repos[$k]
    }
} elseif ($Repos.ContainsKey($Script)) {
    Install-VaultFonts $Script $Repos[$Script]
} else {
    Write-Host "Unknown script: $Script. Available: $($Repos.Keys -join ', ')" -ForegroundColor Red
}

Write-Host "🏛️ Font installation complete! Instantly available across Windows applications." -ForegroundColor Cyan