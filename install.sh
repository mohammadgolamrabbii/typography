#!/usr/bin/env bash
# ==============================================================================
# Open Typography Foundation — Universal Linux / macOS Font Installer
# Curated by Mohammad Golamrabbii
# Zero Rate-Limits, Full High-Speed Mirroring, System-Wide Registration
# ==============================================================================

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m' # No Color

TARGET_LANG="${1:-menu}"

echo -e "${CYAN}${BOLD}"
echo "  ___                      _____                                     _           "
echo " / _ \ _ __   ___ _ __    |_   _|   _ _ __   ___   __ _ _ __ __ _ _ __ | |__  _   _ "
echo "| | | | '_ \ / _ \ '_ \     | || | | | '_ \ / _ \ / _\` | '__/ _\` | '_ \| '_ \| | | |"
echo "| |_| | |_) |  __/ | | |    | || |_| | |_) | (_) | (_| | | | (_| | |_) | | | | |_| |"
echo " \___/| .__/ \___|_| |_|    |_| \__, | .__/ \___/ \__, |_|  \__,_| .__/|_| |_|\__, |"
echo "      |_|                       |___/|_|          |___/          |_|          |___/ "
echo -e "${NC}"
echo -e "${YELLOW}  Curated by Mohammad Golamrabbii • Open Typography Foundation${NC}"
echo -e "${BLUE}  Permanent High-Speed GitHub & Internet Archive Mirrors${NC}"
echo "=============================================================================="

# Detect font installation directory
if [ "$EUID" -eq 0 ]; then
    FONT_DIR="/usr/local/share/fonts/opentypography"
    echo -e "${CYAN}[*] Running as root. Installing system-wide to: ${FONT_DIR}${NC}"
else
    FONT_DIR="${HOME}/.local/share/fonts/opentypography"
    echo -e "${CYAN}[*] Running as user. Installing to: ${FONT_DIR}${NC}"
fi

mkdir -p "${FONT_DIR}"

declare -A REPOS
REPOS["bengali"]="https://github.com/mohammadgolamrabbii/Bangla-Fonts-Mega-Collection.git"
REPOS["cyrillic"]="https://github.com/mohammadgolamrabbii/Cyrillic-Slavic-Mega-Archive.git"
REPOS["japanese"]="https://github.com/mohammadgolamrabbii/Japanese-Fonts-Mega-Archive.git"
REPOS["english"]="https://github.com/mohammadgolamrabbii/English-Latin-Fonts-Archive.git"
REPOS["arabic"]="https://github.com/mohammadgolamrabbii/Arabic-Islamic-Fonts-Archive.git"
REPOS["hindi"]="https://github.com/mohammadgolamrabbii/Hindi-Devanagari-Fonts-Archive.git"
REPOS["german"]="https://github.com/mohammadgolamrabbii/German-Fraktur-Fonts-Archive.git"

install_language() {
    local lang="$1"
    local repo_url="${REPOS[$lang]}"
    local dest="${FONT_DIR}/${lang}"

    if [ -z "$repo_url" ]; then
        echo -e "${RED}[!] Unknown language category: ${lang}${NC}"
        return 1
    fi

    echo -e "\n${YELLOW}>>> Installing ${lang^} Typography Mega Archive...${NC}"
    if [ -d "${dest}/.git" ]; then
        echo -e "${CYAN}[*] Updating existing repository in ${dest}...${NC}"
        git -C "${dest}" pull --ff-only || true
    else
        echo -e "${CYAN}[*] Cloning ${lang} repository (${repo_url})...${NC}"
        rm -rf "${dest}"
        git clone --depth 1 "${repo_url}" "${dest}"
    fi

    local font_count
    font_count=$(find "${dest}" -type f \( -name "*.ttf" -o -name "*.otf" -o -name "*.woff2" -o -name "*.ttc" \) | wc -l)
    echo -e "${GREEN}[✔] Successfully retrieved ${font_count} ${lang} fonts!${NC}"
}

update_font_cache() {
    echo -e "\n${CYAN}[*] Updating fontconfig cache (fc-cache)...${NC}"
    if command -v fc-cache >/dev/null 2>&1; then
        fc-cache -f "${FONT_DIR}"
        echo -e "${GREEN}[✔] Linux Font cache successfully refreshed!${NC}"
    else
        echo -e "${YELLOW}[!] Warning: fc-cache command not found. Please install fontconfig.${NC}"
    fi
}

case "${TARGET_LANG,,}" in
    bengali|bangla)
        install_language "bengali"
        update_font_cache
        ;;
    cyrillic|slavic|russian)
        install_language "cyrillic"
        update_font_cache
        ;;
    japanese|nihongo)
        install_language "japanese"
        update_font_cache
        ;;
    english|latin)
        install_language "english"
        update_font_cache
        ;;
    arabic|islamic)
        install_language "arabic"
        update_font_cache
        ;;
    hindi|devanagari)
        install_language "hindi"
        update_font_cache
        ;;
    german|fraktur)
        install_language "german"
        update_font_cache
        ;;
    all)
        for l in bengali cyrillic japanese english arabic hindi german; do
            install_language "$l"
        done
        update_font_cache
        ;;
    *)
        echo -e "\n${BOLD}Select which typography collection to install:${NC}"
        echo " 1) 🇧🇩 Bengali (3,400+ Fonts)"
        echo " 2) 🇷🇺 Cyrillic & Slavic (10,136 Fonts)"
        echo " 3) 🇯🇵 Japanese / Nihongo (1,100+ Fonts)"
        echo " 4) 🇬🇧 English & Latin (30,800+ Fonts)"
        echo " 5) 🕌 Arabic & Islamic (13,800+ Fonts)"
        echo " 6) 🇮🇳 Hindi & Devanagari (6,000+ Fonts)"
        echo " 7) 🇩🇪 German Fraktur (5,400+ Fonts)"
        echo " 8) 🌐 Install ALL Curated Collections (70,000+ Fonts)"
        echo " 0) Exit"
        echo ""
        read -p "Enter choice [1-8]: " choice

        case "$choice" in
            1) install_language "bengali" ;;
            2) install_language "cyrillic" ;;
            3) install_language "japanese" ;;
            4) install_language "english" ;;
            5) install_language "arabic" ;;
            6) install_language "hindi" ;;
            7) install_language "german" ;;
            8)
                for l in bengali cyrillic japanese english arabic hindi german; do
                    install_language "$l"
                done
                ;;
            0) echo "Installation cancelled."; exit 0 ;;
            *) echo "Invalid choice."; exit 1 ;;
        esac
        update_font_cache
        ;;
esac

echo -e "\n${GREEN}${BOLD}==============================================================================${NC}"
echo -e "${GREEN}${BOLD}  INSTALLATION COMPLETE! ALL FONTS READY ACROSS YOUR SYSTEM.${NC}"
echo -e "${YELLOW}  Curated by Mohammad Golamrabbii for the Open Typography Foundation.${NC}"
echo -e "${GREEN}${BOLD}==============================================================================${NC}\n"
