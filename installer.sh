#!/usr/bin/env bash
set -euo pipefail

ZSHBUDDY_HOME_STR="$(dirname "$(readlink -f "$0")")"
ZSHBUDDY_HOME=$(eval echo "$ZSHBUDDY_HOME_STR")
ZSHBUDDY_BACKUP_DIR="$ZSHBUDDY_HOME/backup/$(date +%Y%m%d_%H%M%S)"

ZSHBUDDY_MARKER="# === ZSHBUDDY START ==="
ZSHBUDDY_END_MARKER="# === ZSHBUDDY END ==="

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

log() { echo -e "${BLUE}[ZSHBuddy]${NC} $1"; }
log_phase() { echo -e "${BLUE}[ZSHBuddy]${NC} \033[1m$1\033[0m"; }
error() { echo -e "${RED}[ZSHBuddy-Error]${NC} \033[1m$1\033[0m" >&2; exit 1; }
success() { echo -e "${GREEN}[ZSHBuddy-Success]${NC} \033[1m$1\033[0m"; }

detect_os() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "macos"
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        echo "linux"
    else
        error "Unsupported operating system: $OSTYPE"
    fi
}

is_command_available() {
    command -v "$1" >/dev/null 2>&1
}

create_backup() {
    local backup_dir="${1}"
    log "Creating backup directory at $backup_dir"
    mkdir -p "$backup_dir"
    
    local files=(".zshrc")
    for file in "${files[@]}"; do
        if [[ -f "$HOME/$file" ]]; then
            log "Backing up $file"
            cp "$HOME/$file" "$backup_dir/"
        fi
    done
}

install_dependencies() {
    local os=$(detect_os)
    
    if [[ "$os" == "macos" ]]; then
        if ! is_command_available brew; then
            error "Homebrew is required. Please install it first: https://brew.sh"
        fi
        brew install bat fzf fd coreutils
    elif [[ "$os" == "linux" ]]; then
        sudo apt update && sudo apt install -y zsh bat fzf fd-find curl
    fi
}

install_antidote() {
    local install_dir="${1}"
    log "Installing Antidote plugin manager in $install_dir..."
    if [[ -d "$install_dir" ]]; then
        log "Antidote already installed, updating..."
        cd "$install_dir"
        git pull
    else
        git clone --depth=1 https://github.com/mattmc3/antidote.git "$install_dir"
    fi
}

switch_shell_to_zsh() {
    if [[ "$SHELL" != "$(which zsh)" ]]; then
        log "Switching default shell to zsh..."
        sudo chsh -s "$(which zsh)" "${USER:-$(whoami)}"
    fi
}

copy_p10k_config() {
    cp "$ZSHBUDDY_HOME/.p10k.zsh.default" "$ZSHBUDDY_HOME/.p10k.zsh"
}

cleanup_markers() {
    local file="$1"
    local os="$(detect_os)"
    case "$os" in
        macos)
            sed -i '' "/$ZSHBUDDY_MARKER/,/$ZSHBUDDY_END_MARKER/d" "$file"
            ;;
        linux)
            sed -i "/$ZSHBUDDY_MARKER/,/$ZSHBUDDY_END_MARKER/d" "$file"
            ;;
        *)
            error "Unsupported operating system: $os"
            ;;
    esac
}

update_zshrc() {    
    # Remove any existing ZSHBuddy configuration
    if [[ -f "$HOME/.zshrc" ]]; then
        cleanup_markers "$HOME/.zshrc"
    fi

    # Prepend ZSHBuddy configuration to .zshrc
    local temp_file=$(mktemp)
    cat > "$temp_file" << EOL

$ZSHBUDDY_MARKER
# ZSHBuddy Configuration - This section must be at the top of .zshrc
# Do not edit this section manually

# Powerlevel10k instant prompt
if [[ -r "\${XDG_CACHE_HOME:-\$HOME/.cache}/p10k-instant-prompt-\${(%):-%n}.zsh" ]]; then
  source "\${XDG_CACHE_HOME:-\$HOME/.cache}/p10k-instant-prompt-\${(%):-%n}.zsh"
fi
$ZSHBUDDY_END_MARKER

EOL

    # Append existing .zshrc if file exists
    if [[ -f "$HOME/.zshrc" ]]; then
        cat "$HOME/.zshrc" >> "$temp_file"
    fi

    # Move temp file to .zshrc
    mv "$temp_file" "$HOME/.zshrc"

    cat >> "$HOME/.zshrc" << EOL

$ZSHBUDDY_MARKER
# ZSHBuddy Configuration - This section must be at the bottom of .zshrc
# Do not edit this section manually
ZSHBUDDY_HOME=$ZSHBUDDY_HOME_STR
source "\$ZSHBUDDY_HOME/zshbuddy-zsh-config.sh"
source "\$ZSHBUDDY_HOME/zshbuddy-extra-config.sh"


# Load antidote
source "\$ZSHBUDDY_HOME/.antidote/antidote.zsh"
zstyle ':antidote:bundle' use-friendly-names 'yes'
antidote load \$ZSHBUDDY_HOME/zsh-plugins.txt

# Load Powerlevel10k configuration
[[ ! -f \$ZSHBUDDY_HOME/.p10k.zsh ]] || source \$ZSHBUDDY_HOME/.p10k.zsh
$ZSHBUDDY_END_MARKER
EOL
}

restore_zshrc() {
    log "Uninstalling ZSHBuddy..."
    
    # Find the most recent backup
    local latest_backup=$(ls -td "$ZSHBUDDY_BACKUP_DIR"/* | head -1)
    
    if [[ -n "$latest_backup" ]]; then
        log "Restoring from backup: $latest_backup"
        for file in "$latest_backup"/*; do
            cp "$file" "$HOME/$(basename "$file")"
        done
    fi
    
    # Remove ZSHBuddy configuration from .zshrc if it somehow made into the backup
    if [[ -f "$HOME/.zshrc" ]]; then
        cleanup_markers "$HOME/.zshrc"
    fi
    
    success "ZSHBuddy has been uninstalled."
    log "Your .zshrc was restored, you can remove ~/.zshbuddy directory."
    log "Please restart your terminal."
}

main() {
    if [[ "${1:-}" == "--help" || "${1:-}" == "-h" ]]; then
        echo "Installs ZSHBuddy, a Zsh auto configurator."
        echo "Usage: $0 [options]"
        echo "Options:"
        echo "  -h, --help       Show this help message and exit"
        echo "  -uninstall  Uninstall ZSHBuddy"
        exit 0
    elif [[ "${1:-}" == "uninstall" ]]; then
        restore_zshrc
        exit 0
    elif [[ -n "${1:-}" ]]; then
        error "Unsupported option: $1"
    fi
    
    log "Starting ZSHBuddy installation..."
    log_phase "* Installing dependencies..."
    install_dependencies
    install_antidote "$ZSHBUDDY_HOME/.antidote"
    copy_p10k_config
    log_phase "* Creating backup..."
    create_backup "$ZSHBUDDY_BACKUP_DIR"
    log_phase "* Updating .zshrc..."
    update_zshrc
    switch_shell_to_zsh
    success "ZSHBuddy has been installed successfully!"
    log "Please restart your terminal."
    log "To customize your prompt further:"
    log " - run: p10k configure, complete wizard but say No to 'Apply changes to ~/.zshrc?' question"
    log "To uninstall ZSHBuddy"
    log "- run: ./installer.sh uninstall"
}

main "$@"
