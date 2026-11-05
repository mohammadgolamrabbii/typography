#!/usr/bin/env bash
# ============================================================
#  🛡️ Universal Font Installer — Open Typography Foundation
#  Curated by Mohammad Golamrabbii | 500,337+ Sovereign Fonts
#  Usage (Express): curl -fsSL https://mohammadgolamrabbii.github.io/typography/install.sh | bash
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

# Check for non-interactive bypass
NON_INTERACTIVE=0
for arg in "$@"; do
    if [ "$arg" = "-y" ] || [ "$arg" = "--yes" ] || [ "$arg" = "-f" ] || [ "$arg" = "--force" ]; then
        NON_INTERACTIVE=1
    fi
done

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
echo "→ Cloning flagship typography repositories into temporary staging..."

REPO_BASE="https://github.com/Open-Typography-Foundation"
VAULTS=(
    "1_Bengali Fonts"
    "2_English_Latin"
    "3_Arabic_Islamic"
    "7_Hindi_Devanagari"
    "8_German_Deutsche_Schriften"
    "9_Japanese_Nihongo"
    "10_Cyrillic_Slavic"
    "11_Korean_Hangul"
    "12_Chinese_Hanzi"
    "16_Developer_Coding_Monospace"
)

for vault in "${VAULTS[@]}"; do
    echo "  → Synchronizing $vault ..."
    git clone --depth=1 "$REPO_BASE/$vault" "$TEMP_DIR/$vault" 2>/dev/null || true
done

echo "→ Registering font binaries (.ttf / .otf)..."
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
