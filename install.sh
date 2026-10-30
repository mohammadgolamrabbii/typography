#!/usr/bin/env bash
# ==============================================================================
#  Open Typography Foundation — Universal Linux / macOS Font Fast-Installer
#  Curated by Mohammad Golamrabbii
#  100% Free Public Digital Heritage • 79 Sovereign Vaults • 95,000+ Production Fonts
# ==============================================================================
set -e

RED="\033[0;31m"
GREEN="\033[0;32m"
BLUE="\033[0;34m"
YELLOW="\033[1;33m"
CYAN="\033[0;36m"
BOLD="\033[1m"
NC="\033[0m"

TARGET_LANG="${1:-menu}"
if [ "$TARGET_LANG" == "--script" ] && [ -n "$2" ]; then
    TARGET_LANG="$2"
fi

echo -e "${CYAN}${BOLD}"
echo "  ___                      _____                                     _           "
echo " / _ \ _ __   ___ _ __    |_   _|   _ _ __   ___   __ _ _ __ __ _ _ __ | |__  _   _ "
echo "| | | | '_ \ / _ \ '_ \     | || | | | '_ \ / _ \ / _` | '__/ _` | '_ \| '_ \| | | |"
echo "| |_| | |_) |  __/ | | |    | || |_| | |_) | (_) | (_| | | | (_| | |_) | | | | |_| |"
echo " \___/| .__/ \___|_| |_|    |_| \__, | .__/ \___/ \__, |_|  \__,_| .__/|_| |_|\__, |"
echo "      |_|                       |___/|_|          |___/          |_|          |___/ "
echo -e "${NC}"
echo -e "${YELLOW}  Curated by Mohammad Golamrabbii • Open Typography Foundation (100% Free)${NC}"
echo -e "${BLUE}  Global Sovereign Architecture (79 Mega-Vaults • 95,000+ Production Fonts)${NC}"
echo "=============================================================================="

if [ "$EUID" -eq 0 ]; then
    FONT_DIR="/usr/local/share/fonts/opentypography"
    echo -e "${CYAN}[*] Running as root. Installing system-wide to: ${FONT_DIR}${NC}"
else
    FONT_DIR="${HOME}/.local/share/fonts/opentypography"
    echo -e "${CYAN}[*] Running as user. Installing to: ${FONT_DIR}${NC}"
fi

mkdir -p "${FONT_DIR}"

declare -A REPOS
REPOS["bangla-mega-collection"]="https://github.com/Open-Typography-Foundation/Bangla-Fonts-Mega-Collection.git"
REPOS["english-latin"]="https://github.com/Open-Typography-Foundation/English-Latin-Fonts-Archive.git"
REPOS["arabic-islamic"]="https://github.com/Open-Typography-Foundation/Arabic-Islamic-Fonts-Archive.git"
REPOS["icons-and-symbols"]="https://github.com/Open-Typography-Foundation/Icons-and-Symbols-Fonts.git"
REPOS["legacy"]="https://github.com/Open-Typography-Foundation/Legacy-Archive-Fonts.git"
REPOS["world-languages"]="https://github.com/Open-Typography-Foundation/World-Languages-Fonts.git"
REPOS["hindi-devanagari"]="https://github.com/Open-Typography-Foundation/Hindi-Devanagari-Fonts-Archive.git"
REPOS["8_german_deutsche_schriften"]="https://github.com/Open-Typography-Foundation/8_German_Deutsche_Schriften.git"
REPOS["japanese-mega"]="https://github.com/Open-Typography-Foundation/Japanese-Fonts-Mega-Archive.git"
REPOS["cyrillic-slavic-mega"]="https://github.com/Open-Typography-Foundation/Cyrillic-Slavic-Mega-Archive.git"
REPOS["korean-hangul"]="https://github.com/Open-Typography-Foundation/Korean-Hangul-Fonts-Archive.git"
REPOS["chinese-hanzi"]="https://github.com/Open-Typography-Foundation/Chinese-Hanzi-Fonts-Archive.git"
REPOS["vietnamese-mega"]="https://github.com/Open-Typography-Foundation/Vietnamese-Fonts-Mega-Archive.git"
REPOS["thai-siam-mega"]="https://github.com/Open-Typography-Foundation/Thai-Siam-Fonts-Mega-Archive.git"
REPOS["malay-nusantara"]="https://github.com/Open-Typography-Foundation/Malay-Nusantara-Fonts-Archive.git"
REPOS["developer-coding-monospace"]="https://github.com/Open-Typography-Foundation/Developer-Coding-Monospace-Fonts-Archive.git"
REPOS["dravidian-mega"]="https://github.com/Open-Typography-Foundation/Dravidian-Fonts-Mega-Archive.git"
REPOS["african-scripts-mega"]="https://github.com/Open-Typography-Foundation/African-Scripts-Mega-Archive.git"
REPOS["persian-urdu-nastaliq"]="https://github.com/Open-Typography-Foundation/Persian-Urdu-Nastaliq-Fonts-Archive.git"
REPOS["hebrew-mega"]="https://github.com/Open-Typography-Foundation/Hebrew-Fonts-Mega-Archive.git"
REPOS["greek-hellenic"]="https://github.com/Open-Typography-Foundation/Greek-Hellenic-Fonts-Archive.git"
REPOS["khmer-cambodian"]="https://github.com/Open-Typography-Foundation/Khmer-Cambodian-Fonts-Archive.git"
REPOS["myanmar-burmese"]="https://github.com/Open-Typography-Foundation/Myanmar-Burmese-Fonts-Archive.git"
REPOS["sinhala-srilankan"]="https://github.com/Open-Typography-Foundation/Sinhala-SriLankan-Fonts-Archive.git"
REPOS["lao-lanxang"]="https://github.com/Open-Typography-Foundation/Lao-LanXang-Fonts-Archive.git"
REPOS["tibetan-himalayan"]="https://github.com/Open-Typography-Foundation/Tibetan-Himalayan-Fonts-Archive.git"
REPOS["georgian-kartvelian"]="https://github.com/Open-Typography-Foundation/Georgian-Kartvelian-Fonts-Archive.git"
REPOS["armenian-haykakan"]="https://github.com/Open-Typography-Foundation/Armenian-Haykakan-Fonts-Archive.git"
REPOS["mongolian-nomadic"]="https://github.com/Open-Typography-Foundation/Mongolian-Nomadic-Fonts-Archive.git"
REPOS["javanese-aksarajawa"]="https://github.com/Open-Typography-Foundation/Javanese-AksaraJawa-Fonts-Archive.git"
REPOS["sundanese-aksarasunda"]="https://github.com/Open-Typography-Foundation/Sundanese-AksaraSunda-Fonts-Archive.git"
REPOS["balinese-aksarabali"]="https://github.com/Open-Typography-Foundation/Balinese-AksaraBali-Fonts-Archive.git"
REPOS["batak-suratbatak"]="https://github.com/Open-Typography-Foundation/Batak-SuratBatak-Fonts-Archive.git"
REPOS["buginese-lontara"]="https://github.com/Open-Typography-Foundation/Buginese-Lontara-Fonts-Archive.git"
REPOS["tagalog-baybayin"]="https://github.com/Open-Typography-Foundation/Tagalog-Baybayin-Fonts-Archive.git"
REPOS["thaana-dhivehi"]="https://github.com/Open-Typography-Foundation/Thaana-Dhivehi-Fonts-Archive.git"
REPOS["chakma-changma"]="https://github.com/Open-Typography-Foundation/Chakma-Changma-Fonts-Archive.git"
REPOS["sylheti-nagri"]="https://github.com/Open-Typography-Foundation/Sylheti-Nagri-Fonts-Archive.git"
REPOS["meetei-mayek"]="https://github.com/Open-Typography-Foundation/Meetei-Mayek-Fonts-Archive.git"
REPOS["odia-oriya"]="https://github.com/Open-Typography-Foundation/Odia-Oriya-Fonts-Archive.git"
REPOS["gujarati-gurjar"]="https://github.com/Open-Typography-Foundation/Gujarati-Gurjar-Fonts-Archive.git"
REPOS["gurmukhi-punjabi"]="https://github.com/Open-Typography-Foundation/Gurmukhi-Punjabi-Fonts-Archive.git"
REPOS["assamese-axomiya"]="https://github.com/Open-Typography-Foundation/Assamese-Axomiya-Fonts-Archive.git"
REPOS["santali-olchiki"]="https://github.com/Open-Typography-Foundation/Santali-OlChiki-Fonts-Archive.git"
REPOS["sora-sompeng"]="https://github.com/Open-Typography-Foundation/Sora-Sompeng-Fonts-Archive.git"
REPOS["lepcha-rong"]="https://github.com/Open-Typography-Foundation/Lepcha-Rong-Fonts-Archive.git"
REPOS["limbu-sirijonga"]="https://github.com/Open-Typography-Foundation/Limbu-Sirijonga-Fonts-Archive.git"
REPOS["newa-prachalit"]="https://github.com/Open-Typography-Foundation/Newa-Prachalit-Fonts-Archive.git"
REPOS["tirhuta-mithilakshar"]="https://github.com/Open-Typography-Foundation/Tirhuta-Mithilakshar-Fonts-Archive.git"
REPOS["syriac-aramaic"]="https://github.com/Open-Typography-Foundation/Syriac-Aramaic-Fonts-Archive.git"
REPOS["coptic-bohairic"]="https://github.com/Open-Typography-Foundation/Coptic-Bohairic-Fonts-Archive.git"
REPOS["tifinagh-amazigh"]="https://github.com/Open-Typography-Foundation/Tifinagh-Amazigh-Fonts-Archive.git"
REPOS["nko-manding"]="https://github.com/Open-Typography-Foundation/NKo-Manding-Fonts-Archive.git"
REPOS["vai-liberian"]="https://github.com/Open-Typography-Foundation/Vai-Liberian-Fonts-Archive.git"
REPOS["adlam-fulani"]="https://github.com/Open-Typography-Foundation/Adlam-Fulani-Fonts-Archive.git"
REPOS["osmanya-somali"]="https://github.com/Open-Typography-Foundation/Osmanya-Somali-Fonts-Archive.git"
REPOS["cherokee-tsalagi"]="https://github.com/Open-Typography-Foundation/Cherokee-Tsalagi-Fonts-Archive.git"
REPOS["canadian-aboriginal"]="https://github.com/Open-Typography-Foundation/Canadian-Aboriginal-Fonts-Archive.git"
REPOS["runic-glagolitic"]="https://github.com/Open-Typography-Foundation/Runic-Glagolitic-Fonts-Archive.git"
REPOS["gothic-ancient"]="https://github.com/Open-Typography-Foundation/Gothic-Ancient-Fonts-Archive.git"
REPOS["ogham-celtic"]="https://github.com/Open-Typography-Foundation/Ogham-Celtic-Fonts-Archive.git"
REPOS["old-permic-abur"]="https://github.com/Open-Typography-Foundation/Old-Permic-Abur-Fonts-Archive.git"
REPOS["old-turkic-orkhon"]="https://github.com/Open-Typography-Foundation/Old-Turkic-Orkhon-Fonts-Archive.git"
REPOS["old-hungarian-rovas"]="https://github.com/Open-Typography-Foundation/Old-Hungarian-Rovas-Fonts-Archive.git"
REPOS["south-arabian-musnad"]="https://github.com/Open-Typography-Foundation/South-Arabian-Musnad-Fonts-Archive.git"
REPOS["phoenician-archaic"]="https://github.com/Open-Typography-Foundation/Phoenician-Archaic-Fonts-Archive.git"
REPOS["avestan-pahlavi"]="https://github.com/Open-Typography-Foundation/Avestan-Pahlavi-Fonts-Archive.git"
REPOS["kharosthi-gandhara"]="https://github.com/Open-Typography-Foundation/Kharosthi-Gandhara-Fonts-Archive.git"
REPOS["brahmi-ashokan"]="https://github.com/Open-Typography-Foundation/Brahmi-Ashokan-Fonts-Archive.git"
REPOS["cuneiform-mesopotamian"]="https://github.com/Open-Typography-Foundation/Cuneiform-Mesopotamian-Fonts-Archive.git"
REPOS["egyptian-hieroglyphs"]="https://github.com/Open-Typography-Foundation/Egyptian-Hieroglyphs-Fonts-Archive.git"
REPOS["linear-a-b-mycenaean"]="https://github.com/Open-Typography-Foundation/Linear-A-B-Mycenaean-Fonts-Archive.git"
REPOS["tangut-western-xia"]="https://github.com/Open-Typography-Foundation/Tangut-Western-Xia-Fonts-Archive.git"
REPOS["nushu-women-script"]="https://github.com/Open-Typography-Foundation/Nushu-Women-Script-Fonts-Archive.git"
REPOS["bassa-vah-liberian"]="https://github.com/Open-Typography-Foundation/Bassa-Vah-Liberian-Fonts-Archive.git"
REPOS["medefaidrin-nigerian"]="https://github.com/Open-Typography-Foundation/Medefaidrin-Nigerian-Fonts-Archive.git"
REPOS["mandaic-gnostic"]="https://github.com/Open-Typography-Foundation/Mandaic-Gnostic-Fonts-Archive.git"
REPOS["samaritan-hebrew"]="https://github.com/Open-Typography-Foundation/Samaritan-Hebrew-Fonts-Archive.git"
REPOS["hanifi-rohingya"]="https://github.com/Open-Typography-Foundation/Hanifi-Rohingya-Fonts-Archive.git"

install_repo() {
    local key="$1"
    local url="${REPOS[$key]}"
    if [ -z "$url" ]; then
        echo -e "${RED}[!] Unknown script: $key${NC}"
        return 1
    fi
    echo -e "${BLUE}[*] Fetching typography vault: $key...${NC}"
    local dest="${FONT_DIR}/$key"
    if [ -d "$dest" ]; then
        git -C "$dest" pull --quiet || true
    else
        git clone --depth 1 --quiet "$url" "$dest"
    fi
    echo -e "${GREEN}[✓] Successfully mirrored $key fonts!${NC}"
}

if [ "$TARGET_LANG" == "all" ]; then
    echo -e "${YELLOW}[*] Installing all 79 typography vaults...${NC}"
    for k in "${!REPOS[@]}"; do
        install_repo "$k"
    done
elif [ "$TARGET_LANG" == "menu" ]; then
    echo "Available scripts to install:"
    for k in "${!REPOS[@]}"; do
        echo "  - $k"
    done
    echo ""
    echo "Usage: ./install.sh <script_name> or ./install.sh all"
else
    install_repo "$TARGET_LANG"
fi

if command -v fc-cache >/dev/null 2>&1; then
    echo -e "${CYAN}[*] Rebuilding font cache (fc-cache)...${NC}"
    fc-cache -f "${FONT_DIR}"
fi

echo -e "${GREEN}${BOLD}[✓] Installation complete! All fonts are immediately accessible in your applications.${NC}"