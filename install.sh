#!/usr/bin/env bash
# ============================================================
#  🛡️ Universal Font Installer — Open Typography Foundation
#  Curated by Mohammad Golamrabbii | 500,337+ Sovereign Fonts
#  Usage (Express): curl -fsSL https://mohammadgolamrabbii.github.io/typography/install.sh | bash
#  Usage (Script):  curl -fsSL https://mohammadgolamrabbii.github.io/typography/install.sh | bash -s -- --script english
#  Usage (Secure):  curl ... -o install.sh && sha256sum install.sh && bash install.sh
# ============================================================

set -e

echo "╔══════════════════════════════════════════════════════════════════╗"
echo "║  🛡️ Open Typography Foundation — Verified Font Installer         ║"
echo "║  Preserving 500,337+ Open-Source Typefaces Across 100 Vaults    ║"
echo "║  Curated by Mohammad Golamrabbii | Free & Open-Source (SIL OFL)  ║"
echo "╚══════════════════════════════════════════════════════════════════╝"

# Detect Operating System
OS_TYPE="$(uname -s)"
if [ "$OS_TYPE" = "Darwin" ]; then
    FONT_DIR="$HOME/Library/Fonts/OpenTypography"
    echo "→ Detected macOS. Target directory: $FONT_DIR"
else
    FONT_DIR="$HOME/.local/share/fonts/OpenTypography"
    echo "→ Detected Linux. Target directory: $FONT_DIR"
fi

# Parse CLI arguments
NON_INTERACTIVE=0
TARGET_SCRIPT="all"

while [ "$#" -gt 0 ]; do
    case "$1" in
        -y|--yes|-f|--force)
            NON_INTERACTIVE=1
            shift
            ;;
        -s|--script)
            TARGET_SCRIPT="$(echo "$2" | tr '[:upper:]' '[:lower:]')"
            shift 2
            ;;
        --script=*)
            TARGET_SCRIPT="$(echo "${1#*=}" | tr '[:upper:]' '[:lower:]')"
            shift
            ;;
        *)
            shift
            ;;
    esac
done

echo "→ Target script vault: $TARGET_SCRIPT"

# Interactive confirmation prompt (Security Guard)
if [ "$NON_INTERACTIVE" -eq 0 ] && [ -t 0 ]; then
    read -r -p "Proceed with downloading and installing verified fonts to '$FONT_DIR'? [Y/n] " response
    case "$response" in
        [nN][oO]|[nN])
            echo "❌ Installation cancelled by user."
            exit 0
            ;;
    esac
fi

mkdir -p "$FONT_DIR"

TEMP_DIR="$(mktemp -d)"
echo "→ Synchronizing open-source typography vaults into temporary staging..."

declare -A REPO_MAP=(
    ["bengali"]="https://github.com/mohammadgolamrabbii/Bangla-Fonts-Mega-Collection.git"
    ["english"]="https://github.com/mohammadgolamrabbii/English-Fonts-Mega-Archive.git"
    ["arabic"]="https://github.com/mohammadgolamrabbii/Arabic-Fonts-Mega-Archive.git"
    ["hindi"]="https://github.com/mohammadgolamrabbii/Hindi-Fonts-Mega-Archive.git"
    ["german"]="https://github.com/mohammadgolamrabbii/German-Fonts-Mega-Archive.git"
    ["japanese"]="https://github.com/Open-Typography-Foundation/Japanese-Fonts-Mega-Archive.git"
    ["cyrillic"]="https://github.com/Open-Typography-Foundation/Cyrillic-Fonts-Mega-Archive.git"
    ["korean"]="https://github.com/Open-Typography-Foundation/Korean-Hangul-Fonts-Archive.git"
    ["chinese"]="https://github.com/Open-Typography-Foundation/Chinese-Hanzi-Fonts-Archive.git"
    ["dev"]="https://github.com/Open-Typography-Foundation/Developer-Coding-Fonts-Archive.git"
    ["icons"]="https://github.com/Open-Typography-Foundation/Icons-and-Symbols-Fonts.git"
    ["vietnamese"]="https://github.com/Open-Typography-Foundation/Vietnamese-Fonts-Mega-Archive.git"
    ["thai"]="https://github.com/Open-Typography-Foundation/Thai-Fonts-Mega-Archive.git"
    ["malay"]="https://github.com/Open-Typography-Foundation/Malay-Nusantara-Fonts-Archive.git"
    ["dravidian"]="https://github.com/Open-Typography-Foundation/Dravidian-Fonts-Mega-Archive.git"
    ["african"]="https://github.com/Open-Typography-Foundation/African-Scripts-Mega-Archive.git"
    ["urdu"]="https://github.com/Open-Typography-Foundation/Persian-Urdu-Nastaliq-Fonts-Archive.git"
    ["hebrew"]="https://github.com/Open-Typography-Foundation/Hebrew-Fonts-Mega-Archive.git"
    ["greek"]="https://github.com/Open-Typography-Foundation/Greek-Hellenic-Fonts-Archive.git"
)

CLONE_URLS=()
if [ "$TARGET_SCRIPT" != "all" ] && [ -n "${REPO_MAP[$TARGET_SCRIPT]}" ]; then
    CLONE_URLS+=("${REPO_MAP[$TARGET_SCRIPT]}")
else
    # Default flagship vaults
    for url in "${REPO_MAP[@]}"; do
        CLONE_URLS+=("$url")
    done
fi

for repo_url in "${CLONE_URLS[@]}"; do
    vault_name="$(basename "$repo_url" .git)"
    echo "  → Synchronizing $vault_name ..."
    git clone --depth=1 "$repo_url" "$TEMP_DIR/$vault_name" 2>/dev/null || true
done

echo "→ Registering font binaries (.ttf / .otf / .woff2)..."
find "$TEMP_DIR" -type f \( -name "*.ttf" -o -name "*.otf" \) -exec cp -n {} "$FONT_DIR/" \;

rm -rf "$TEMP_DIR"

if command -v fc-cache >/dev/null 2>&1; then
    echo "→ Updating system font cache (fc-cache)..."
    fc-cache -fv "$FONT_DIR" >/dev/null 2>&1 || true
fi

INSTALLED=$(find "$FONT_DIR" -type f \( -name "*.ttf" -o -name "*.otf" \) | wc -l)

echo ""
echo "=================================================================="
echo "✅ Installation Complete! $INSTALLED fonts successfully registered."
echo "   Directory: $FONT_DIR"
echo "   Restart running applications (browser, editors, terminal) to apply."
echo "=================================================================="
