# ==============================================================================
# Liquid Chrome - Oh-My-Zsh Theme
# ==============================================================================
# A highly specific crossover between Frutiger Aero (aquatic, glass, glow) and
# Gen X Soft Club (sterile minimalism, Y2K techno translucency, sharp geometry).
# ==============================================================================

# Helper to retrieve active Git repository info with custom styling
_liquid_chrome_git_status() {
  # Check if we are inside a Git repository
  if git rev-parse --is-inside-work-tree &>/dev/null; then
    local branch
    branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
    
    # Check for dirty, unstaged, or untracked changes
    local status_symbol
    if [[ -n $(git status --porcelain 2>/dev/null) ]]; then
      # Bioluminescent Lime Green indicator for dirty/active files
      status_symbol="%F{green}●%f"
    else
      # Aquatic Cyan indicator for clean master repository status
      status_symbol="%F{cyan}○%f"
    fi
    
    # Silver trim brackets surrounding the cyan branch and status dot
    echo " %F{white}[%F{cyan}${branch} ${status_symbol}%F{white}]%f"
  fi
}

# Helper for return status of the last executed command
_liquid_chrome_return_status() {
  # If previous command exited with error, show red warning dot, else clean cyan indicator
  echo "%(?.%F{cyan}❯%f.%F{red}▲%f)"
}

# ------------------------------------------------------------------------------
# Prompt Design Layout
# ------------------------------------------------------------------------------
# Line 1: [HH:MM:SS] | Directory | Git branch
# Line 2: Surgical path prompt connector and execution caret
# ------------------------------------------------------------------------------
PROMPT='
%F{cyan}┌─%F{white}[%F{cyan}%D{%H:%M:%S}%F{white}]%F{white}─%F{white}[%F{white}%~%F{white}]%f$(_liquid_chrome_git_status)
%F{cyan}└─%f$(_liquid_chrome_return_status)%F{green}❯%f '

# Clean up environment variables to prevent leakage
unset ZSH_THEME_GIT_PROMPT_PREFIX
unset ZSH_THEME_GIT_PROMPT_SUFFIX
unset ZSH_THEME_GIT_PROMPT_DIRTY
unset ZSH_THEME_GIT_PROMPT_CLEAN
