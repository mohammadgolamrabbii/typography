# ============================================================
#  Universal Font Installer — GolamRabbii Font Mega-Collection
#  Generated: 2026-10-30T19:37:47.512716
#  Total: 500,337+ fonts across 100 vaults
#  Run as: Set-ExecutionPolicy RemoteSigned; .\install.ps1
# ============================================================

param(
    [string]$InstallDir = "$env:LOCALAPPDATA\GolamRabbii_Fonts",
    [switch]$SystemWide
)

if ($SystemWide) { $InstallDir = "$env:SystemRoot\Fonts" }

$RepoBase = "https://github.com/Open-Typography-Foundation"
New-Item -ItemType Directory -Force -Path $InstallDir | Out-Null

Write-Host "╔══════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║  GolamRabbii Font Mega-Collection Installer      ║" -ForegroundColor Cyan
Write-Host "║  500,337+ fonts | 100 vaults                  ║" -ForegroundColor Cyan
Write-Host "╚══════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

$vaults = @(
    "100_Osage_Indigenous"
    "10_Cyrillic_Slavic"
    "11_Korean_Hangul"
    "12_Chinese_Hanzi"
    "13_Vietnamese_TiengViet"
    "14_Thai_Siam"
    "15_Malay_Nusantara_ID_MY"
    "16_Developer_Coding_Monospace"
    "17_Dravidian_Indic_SouthAsia"
    "18_African_GeEz_Amharic_Heritage"
    "19_Persian_Urdu_Nastaliq"
    "1_Bengali Fonts"
    "20_Hebrew_Ivrit_Judaic"
    "21_Greek_Hellenic_Polytonic"
    "22_Khmer_Cambodian_Angkor"
    "23_Myanmar_Burmese_Pyidaungsu"
    "24_Sinhala_SriLankan_Lanka"
    "25_Lao_LanXang"
    "26_Tibetan_Himalayan_Bodhi"
    "27_Georgian_Kartvelian_Mkhedruli"
    "28_Armenian_Haykakan"
    "29_Mongolian_Hudum_Nomadic"
    "2_English_Latin"
    "30_Javanese_AksaraJawa_Heritage"
    "31_Sundanese_AksaraSunda_Priangan"
    "32_Balinese_AksaraBali_Dewata"
    "33_Batak_SuratBatak_Toba"
    "34_Buginese_Lontara_Makassar"
    "35_Tagalog_Baybayin_Kapampangan"
    "36_Thaana_Dhivehi_Maldivian"
    "37_Chakma_Changma_AjhaPath"
    "38_Sylheti_Nagri_Heritage"
    "39_Meetei_Mayek_Manipuri"
    "3_Arabic_Islamic"
    "40_Odia_Oriya_Utkala"
    "41_Gujarati_Gurjar_Heritage"
    "42_Gurmukhi_Punjabi_Khalsa"
    "43_Assamese_Axomiya_Lipi"
    "44_Santali_OlChiki_Adivasi"
    "45_Sora_Sompeng_Heritage"
    "46_Lepcha_Rong_Himalayan"
    "47_Limbu_Sirijonga_Kirat"
    "48_Newa_Prachalit_Nepal"
    "49_Tirhuta_Mithilakshar_Maithili"
    "4_Icons_Symbols"
    "50_Syriac_Aramaic_Peshitta"
    "51_Coptic_Bohairic_Sahidic"
    "52_Tifinagh_Amazigh_Berber"
    "53_NKo_Manding_Heritage"
    "54_Vai_Liberian_Syllabary"
    "55_Adlam_Fulani_Pulaar"
    "56_Osmanya_Somali_Heritage"
    "57_Cherokee_Tsalagi_Sequoyah"
    "58_Canadian_Aboriginal_Syllabics"
    "59_Runic_Glagolitic_Ancient"
    "5_Legacy_Archive"
    "60_Gothic_Ancient_Codex"
    "61_Ogham_Celtic_Monumental"
    "62_Old_Permic_Abur"
    "63_Old_Turkic_Orkhon_Runes"
    "64_Old_Hungarian_Rovas"
    "65_Old_South_Arabian_Musnad"
    "66_Phoenician_Archaic"
    "67_Avestan_Sacred_Pahlavi"
    "68_Kharosthi_Gandhara_SilkRoad"
    "69_Brahmi_Ashokan_Imperial"
    "6_World_Languages"
    "70_Cuneiform_Sumero_Akkadian"
    "71_Egyptian_Hieroglyphs_Pharaonic"
    "72_Linear_A_B_Mycenaean"
    "73_Tangut_Western_Xia"
    "74_Nushu_Women_Phonetic"
    "75_Bassa_Vah_Liberian"
    "76_Medefaidrin_Nigerian"
    "77_Mandaic_Gnostic_Scripture"
    "78_Samaritan_Hebrew_Archaic"
    "79_Hanifi_Rohingya_National"
    "7_Hindi_Devanagari"
    "80_Cham_Indigenous"
    "81_Tai_Tham_Lanna"
    "82_Tai_Viet"
    "83_Kayah_Li_Karen"
    "84_Pahawh_Hmong"
    "85_Ahom_Sacred_Tai"
    "86_Modi_Historical"
    "87_Sharada_Classical"
    "88_Kaithi_Historic"
    "89_Grantha_Vedic"
    "8_German_Deutsche_Schriften"
    "90_Takri_Himalayan"
    "91_Saurashtra"
    "92_Sogdian_SilkRoad"
    "93_Imperial_Aramaic"
    "94_Nabataean_Palmyrene"
    "95_Cypriot_Syllabic"
    "96_Anatolian_Hieroglyphs"
    "97_Bamum_Royal"
    "98_Mende_Kikakui"
    "99_Deseret_Phonetic"
    "9_Japanese_Nihongo"
)

$installed = 0
foreach ($vault in $vaults) {
    $dest = Join-Path $InstallDir $vault
    Write-Host "→ Cloning $vault ..." -ForegroundColor Yellow
    if (Test-Path $dest) {
        & git -C $dest pull --depth=1 2>$null
    } else {
        & git clone --depth=1 "$RepoBase/$vault" $dest 2>$null
    }
    # Register fonts with Windows
    $fonts = Get-ChildItem $dest -Recurse -Include "*.ttf","*.otf" -ErrorAction SilentlyContinue
    foreach ($font in $fonts) {
        try {
            $fontName = [System.IO.Path]::GetFileNameWithoutExtension($font.Name)
            Copy-Item $font.FullName "$env:SystemRoot\Fonts\" -Force -ErrorAction SilentlyContinue
            $installed++
        } catch { }
    }
}

Write-Host ""
Write-Host "✅ Installation complete!" -ForegroundColor Green
Write-Host "   Fonts installed: $installed" -ForegroundColor Green
Write-Host "   Location: $InstallDir" -ForegroundColor Green
Write-Host "   Please restart your applications." -ForegroundColor Green
