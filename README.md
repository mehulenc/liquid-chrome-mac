# Liquid Chrome Mac Theme

A highly specific crossover configuration between **Frutiger Aero** (eco-utopian, high-gloss, aquatic, glassmorphism) and **Gen X Soft Club** (Y2K techno translucency, ambient wireframes, sterile minimalism, and technical typography) designed for macOS.

This repository contains configurations for the **Kitty Terminal**, a custom **Oh-My-Zsh theme**, and **Übersicht** desktop widgets.

---

## 📸 Aesthetic Profile

*   **Background Base:** `#0B1021` (Deep Ambient Blue)
*   **Translucent Base:** `rgba(11, 16, 33, 0.45)` (Frosted plastic/thick glass window materials)
*   **Primary Accent 1:** `#00FFFF` (Aquatic Cyan)
*   **Primary Accent 2:** `#39FF14` (Bioluminescent Lime Green)
*   **Borders & Trim:** `rgba(255, 255, 255, 0.25)` (Silver metallic edge catching virtual light)
*   **Fonts:** `Helvetica Neue` (Thin weights for headers) and `SF Mono` / `JetBrains Mono` (for code/terminals)

---

## 📂 Repository Structure

```
.
├── kitty/
│   └── kitty.conf               # Kitty configuration (Translucency, blur, and 16 ANSI color mappings)
├── zsh/
│   └── liquid-chrome.zsh-theme  # Custom Zsh branch & command status theme for Oh-My-Zsh
├── widgets/
│   ├── clock/
│   │   └── index.coffee         # Minimal floating desktop clock
│   ├── stats/
│   │   └── index.coffee         # Minimalist CPU & RAM wireframe gauges
│   └── nowplaying/
│       ├── index.coffee         # Music status display with cover art and progress bar
│       └── get_music_info.scpt  # AppleScript helper for Spotify/Apple Music extraction
├── deploy.sh                    # Automated symlinker deployment script
└── AGENTS.md                    # Core aesthetic protocol rules
```

---

## 🚀 Installation & Deployment

### 1. Run the Auto-Deployer
The included deployment script automatically creates target folders, backs up your existing configuration files, and symlinks files from this repository directly to their standard active system paths:

```bash
# Make the deployment script executable (if needed)
chmod +x deploy.sh

# Run the deployer
./deploy.sh
```

### 2. Required Font Dependencies
To render the system symbols correctly in Übersicht widgets, you must install the official Apple SF Pro fonts and symbols:

```bash
# Install San Francisco Pro Fonts
brew install --cask font-sf-pro

# Install SF Symbols Application
brew install --cask sf-symbols
```

---

## ⚙️ Manual System Customization

To complete the layout, apply these adjustments in your macOS **System Settings**:

### macOS Appearance Settings
1.  **Appearance:** Set to **Dark** (activates `#0B1021` deep-mode backing scales).
2.  **Accent Color:** Choose **Custom** and enter `#00FFFF` (Aquatic Cyan).
3.  **Highlight Color:** Choose **Custom** and enter `#39FF14` (Bioluminescent Lime Green) or `#00FFFF`.
4.  **Sidebar Icon Size:** Set to **Small**.
5.  **Allow wallpaper tinting in windows:** Set to **ON** (combines window translucency with your wallpaper).
6.  **Widgets & Icons Style:** Set to **Tinted** and configure the tint color to `#00FFFF` (Aquatic Cyan).
7.  **Reduce transparency** (Accessibility $\rightarrow$ Display): Set to **OFF** (mandatory to keep the frosted glass effects active).

### Menu Bar Tinting & Custom Shape (with Ice)
We recommend using the open-source **Ice** application to style your menu bar:
1.  Open **Ice** Settings $\rightarrow$ **Design**.
2.  Enable **Menu Bar Shape**, select **Rounded Capsule**, and set the corner radius to `10px` or `12px`.
3.  Set the **Border** color to white (`#FFFFFF`) at `25%` opacity for the silver metallic edge.
4.  Enable **Menu Bar Tinting**, set to Solid, and enter `#0B1021` (Deep Ambient Blue) at `45%` opacity.
