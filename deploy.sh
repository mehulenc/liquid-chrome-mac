#!/usr/bin/env bash

# ==============================================================================
# Liquid Chrome - Configuration Deployment Script
# ==============================================================================
# Automatically symlinks the Liquid Chrome configuration files (Kitty,
# Uebersicht, Zsh, Neovim) from this workspace to their standard macOS
# configuration directories with robust error handling and backups.
# ==============================================================================

set -euo pipefail

# Color codes for clean output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

log_info() {
  echo -e "${CYAN}[INFO]${NC} $1"
}

log_success() {
  echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warn() {
  echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
  echo -e "${RED}[ERROR]${NC} $1" >&2
}

# Source directory (current script's directory)
WORKSPACE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

# Define deployment targets: [source_file] [target_path]
# Relative to WORKSPACE_DIR and HOME
deploy_link() {
  local src_name="$1"
  local dest_path="$2"
  local src_file="${WORKSPACE_DIR}/${src_name}"
  
  # Ensure the source file actually exists in the workspace
  if [[ ! -f "$src_file" ]]; then
    log_error "Source file not found in workspace: $src_file"
    return 1
  fi

  local dest_dir
  dest_dir="$(dirname "$dest_path")"

  # Create destination directory if it does not exist
  if [[ ! -d "$dest_dir" ]]; then
    log_info "Creating target directory: $dest_dir"
    if ! mkdir -p "$dest_dir"; then
      log_error "Failed to create target directory: $dest_dir"
      return 1
    fi
  fi

  # Backup existing file/symlink if it is not already a symlink pointing to the correct source
  if [[ -e "$dest_path" || -L "$dest_path" ]]; then
    if [[ -L "$dest_path" && "$(readlink "$dest_path")" == "$src_file" ]]; then
      log_success "Symlink already correctly set up: $dest_path -> $src_name"
      return 0
    fi
    
    local backup_path="${dest_path}.backup.$(date +%Y%m%d%H%M%S)"
    log_warn "Existing file found at $dest_path. Creating backup at $backup_path"
    if ! mv "$dest_path" "$backup_path"; then
      log_error "Failed to create backup for: $dest_path"
      return 1
    fi
  fi

  # Create symlink
  log_info "Creating symbolic link: $dest_path -> $src_file"
  if ln -sf "$src_file" "$dest_path"; then
    log_success "Successfully linked $dest_path"
  else
    log_error "Failed to link $dest_path"
    return 1
  fi
}

echo -e "${CYAN}======================================================================${NC}"
echo -e "${CYAN}             Deploying Liquid Chrome Configuration Files              ${NC}"
echo -e "${CYAN}======================================================================${NC}"

# 1. Kitty Terminal configuration
deploy_link "kitty/kitty.conf" "${HOME}/.config/kitty/kitty.conf"

# 2. Übersicht Widgets
# Clock Widget
deploy_link "widgets/clock/index.coffee" "${HOME}/Library/Application Support/Übersicht/widgets/liquid-chrome-clock/index.coffee"
# Stats Widget
deploy_link "widgets/stats/index.coffee" "${HOME}/Library/Application Support/Übersicht/widgets/liquid-chrome-stats/index.coffee"
# Now Playing Widget
deploy_link "widgets/nowplaying/index.coffee" "${HOME}/Library/Application Support/Übersicht/widgets/liquid-chrome-nowplaying/index.coffee"
deploy_link "widgets/nowplaying/get_music_info.applescript" "${HOME}/Library/Application Support/Übersicht/widgets/liquid-chrome-nowplaying/get_music_info.applescript"

# 3. Oh-My-Zsh Custom Theme (optional/if Oh-My-Zsh is installed)
if [[ -d "${HOME}/.oh-my-zsh" ]]; then
  deploy_link "zsh/liquid-chrome.zsh-theme" "${HOME}/.oh-my-zsh/custom/themes/liquid-chrome.zsh-theme"
else
  log_warn "Oh-My-Zsh is not installed (~/.oh-my-zsh not found). Skipping Zsh theme link."
fi

# 4. Neovim configuration
deploy_link "nvim/init.lua" "${HOME}/.config/nvim/init.lua"

echo -e "${CYAN}======================================================================${NC}"
log_success "Deployment process completed!"
echo -e "You can reload services to apply all changes:"
echo -e "  - Kitty: Control + Command + ,"
echo -e "  - Uebersicht: Refresh All Widgets via menu bar"
echo -e "  - Zsh: source ~/.zshrc"
echo -e "${CYAN}======================================================================${NC}"
