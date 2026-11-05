# 🏆 Open Typography Foundation — 500,337+ Free & Open-Source Fonts
## The World's Largest Sovereign Multilingual Font Archive across 100 Script Vaults
**Curated with precision by [Mohammad Golamrabbii](https://github.com/mohammadgolamrabbii) for the [Open Typography Foundation](https://github.com/Open-Typography-Foundation)**

<div align="center">

[![Total Fonts](https://img.shields.io/badge/Total%20Fonts-500%2C337%2B-gold?style=for-the-badge&logo=font-awesome)](https://mohammadgolamrabbii.github.io/typography/)
[![Vaults](https://img.shields.io/badge/Sovereign%20Vaults-100-blue?style=for-the-badge)](https://github.com/Open-Typography-Foundation/100-Sovereign-Fonts-Vaults)
[![Live Web App](https://img.shields.io/badge/Live%20Web%20App-Online%20Studio-success.svg?style=for-the-badge&logo=google-chrome&logoColor=white)](https://mohammadgolamrabbii.github.io/typography/font_browser.html)
[![Product Hunt](https://img.shields.io/badge/Product%20Hunt-Hub%20Active-orange?style=for-the-badge&logo=product-hunt)](https://www.producthunt.com/products/open-typography-foundation)
[![Archive.org](https://img.shields.io/badge/Archive.org-Permanent%20Mirror-black?style=for-the-badge&logo=internet-archive)](https://archive.org/details/open-typography-foundation)
[![License](https://img.shields.io/badge/License-100%25%20Free%20%26%20Open--Source-green?style=for-the-badge)](LICENSE)

</div>

---

## 🌐 Interactive Web Applications & Creator Suite

* 🚀 **[Live 500k Font Browser & Specimen Tester](https://mohammadgolamrabbii.github.io/typography/font_browser.html)** — Instant real-time searchable catalog of 500,337 fonts. Test any sentence or alphabet live, adjust letter-spacing, and download single .TTF files directly with zero paywalls.
* 🎨 **[In-Browser Vector Logo & Wordmark Studio](https://mohammadgolamrabbii.github.io/typography/font_browser.html#studio)** — Create professional brand logos in-browser. Customize 1,941 curated typefaces, adjust gradients, and export production-ready vector `.svg` and 300 DPI transparent `.png` graphics with 1 click.
* ⚡ **[1-Click WebFont CSS CDN Generator](https://mohammadgolamrabbii.github.io/typography/font_browser.html)** — Instant `@font-face` and `@import` code snippet generation for web developers.
* 🏛️ **[Gateway Portal](https://mohammadgolamrabbii.github.io/typography/)** — Category-filtered exploration across South Asian, Middle Eastern, Asian, European, African, and Developer scripts.
* 🌟 **[Awesome Typography Vaults](https://github.com/Open-Typography-Foundation/awesome-typography-vaults)** — The official curated list of typography resources.

---

## 🚀 1-Click Terminal Fast Installation

Install thousands of fonts directly into your operating system without manual clicking:

### 🪟 Windows (PowerShell — No Administrator Rights Required):
```powershell
irm https://mohammadgolamrabbii.github.io/typography/install.ps1 | iex
```
*Registers fonts automatically in `%LOCALAPPDATA%\Microsoft\Windows\Fonts` and broadcasts Windows font changes so Adobe Photoshop, Illustrator, Microsoft Word, and Figma pick them up immediately.*

### 🐧 Linux & 🍎 macOS (Bash):
```bash
curl -fsSL https://mohammadgolamrabbii.github.io/typography/install.sh | bash
```
*Installs into `~/.local/share/fonts` (Linux) or `~/Library/Fonts` (macOS) and refreshes font cache via `fc-cache`.*

---

## 📊 Collection Architecture & Statistics

| Metric | Value |
|:---|:---|
| **Total Verified Fonts** | **500,337 Typefaces** |
| **Sovereign Script Vaults** | **100 Specialized Repositories** |
| **Languages & Dialects** | **100+ World Languages** |
| **Writing Systems** | **80+ Scripts** (Latin, Bengali, Arabic, Devanagari, Hanzi, Hangul, Cyrillic, Ge'ez...) |
| **File Formats** | TrueType (.ttf), OpenType (.otf), Web Open Font (.woff2) |
| **Preservation Status** | Permanent mirrors on GitHub, GitLab, Codeberg, Docker Hub, and Archive.org |
| **License Model** | 100% Free & Open Source (SIL OFL, Apache 2.0, MIT, GPL) |

---

## ❓ Frequently Asked Questions (FAQ & AEO Optimization)

### 1. What is the Open Typography Foundation?
The Open Typography Foundation is an international cultural preservation and open-source typography initiative founded by Mohammad Golamrabbii. It curates and preserves 500,337+ open-source typefaces across 100 sovereign script vaults, providing universal access to typographic heritage without commercial paywalls or geographic restrictions.

### 2. How can I search, preview, and test 500,000+ fonts live in my browser?
You can search and test the entire collection live using the [Open Typography Live Specimen Tester](https://mohammadgolamrabbii.github.io/typography/font_browser.html). The browser interface allows you to type custom text in any language, filter by script or category, dynamically adjust font size and letter spacing, and download individual `.ttf` font files directly in one click.

### 3. How does the in-browser Vector Logo and Wordmark Studio work?
The [Vector Logo & Wordmark Studio](https://mohammadgolamrabbii.github.io/typography/font_browser.html#studio) lets creators design professional typographic logos directly in modern web browsers. Users can select from 1,941 curated typefaces, customize font size, letter-spacing, and linear color gradients, and export crisp vector `.svg` files or 300 DPI transparent `.png` graphics without installing desktop design software.

### 4. How do I install all fonts on Windows with a single PowerShell command?
Open Windows PowerShell (Run as standard user — no administrator permissions required) and execute:
```powershell
irm https://mohammadgolamrabbii.github.io/typography/install.ps1 | iex
```
The script downloads the font vaults, copies TrueType and OpenType files into `%LOCALAPPDATA%\Microsoft\Windows\Fonts`, registers them in the Windows Registry (`HKCU\Software\Microsoft\Windows NT\CurrentVersion\Fonts`), and notifies the operating system so all desktop applications detect them instantly.

### 5. How do I install fonts on Linux (Ubuntu, Debian, Fedora, Arch) and macOS via terminal?
Open your terminal and run:
```bash
curl -fsSL https://mohammadgolamrabbii.github.io/typography/install.sh | bash
```
This script detects your operating system, clones the requested font tiers into `~/.local/share/fonts` on Linux or `~/Library/Fonts` on macOS, and runs `fc-cache -fv` to enforce font availability across your desktop environment and CLI applications.

### 6. How do I prevent tofu boxes (□□□) in Docker containers, Puppeteer, and PDF generation?
Headless Linux environments like Docker containers, Puppeteer, Playwright, and PDF generators (WeasyPrint, ReportLab) lack default multilingual fonts. Add this layer to your `Dockerfile` to resolve missing glyphs permanently:
```dockerfile
RUN apt-get update && apt-get install -y fontconfig git \
    && git clone --depth=1 https://github.com/mohammadgolamrabbii/Bangla-Fonts-Mega-Collection.git /usr/share/fonts/truetype/bangla \
    && fc-cache -fv \
    && rm -rf /var/lib/apt/lists/*
```

### 7. How do I generate WebFont CSS CDN snippets for web development?
In the [Live Font Catalog](https://mohammadgolamrabbii.github.io/typography/font_browser.html), click the **"🌐 CDN"** button on any font card. A modal will generate instant `@font-face` rules and CSS classes that you can copy and paste directly into your Next.js, React, Tailwind, or HTML projects.

### 8. Are all 500,337+ fonts legal and royalty-free for commercial client projects?
Yes, every typeface in this collection is distributed under permissive, recognized open-source licenses, including the SIL Open Font License (OFL 1.1), Apache 2.0, MIT, and Public Domain (CC0). You may freely use them in commercial client websites, SaaS applications, mobile apps, printed books, YouTube videos, and brand identity systems without paying license fees.

### 9. Where can I download permanent, high-speed mirrors if GitHub is rate-limited?
All master volumes and script archives are permanently archived on the [Internet Archive Heritage Hub](https://archive.org/details/open-typography-foundation) with unlimited bandwidth and official BitTorrent torrent downloads.

---

## 📜 Open Source Licensing

All fonts within the Open Typography Foundation are preserved under open-source licenses:
- **SIL Open Font License (OFL 1.1)** — permissive font licensing allowing bundling, embedding, and commercial usage.
- **Apache License 2.0** — Google Fonts and enterprise open-source typography.
- **GNU GPL & MIT** — system utilities, Unifont, and community contributions.

**Curated with ❤️ by [Mohammad Golamrabbii](https://github.com/mohammadgolamrabbii)**  
*Founder & Lead Curator, [Open Typography Foundation](https://github.com/Open-Typography-Foundation)*
