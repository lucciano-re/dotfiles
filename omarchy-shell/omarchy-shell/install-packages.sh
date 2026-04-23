#!/bin/bash
# install-packages.sh
set -e

echo "Updating system and installing base dependencies..."
# Install everything in pkglist.txt + alias dependencies
sudo pacman -Syu --needed - < paclist.txt

# Check for yay
if ! command -v yay &> /dev/null; then
    echo "Installing yay..."
    sudo pacman -S --needed --noconfirm base-devel git
    TEMP_DIR=$(mktemp -d)
    git clone https://aur.archlinux.org/yay.git "$TEMP_DIR/yay"
    cd "$TEMP_DIR/yay" && makepkg -si --noconfirm
    rm -rf "$TEMP_DIR"
fi

# Install everything in aurlist.txt
echo "Installing AUR packages..."
yay -S --noconfirm --answerdiff None --answeredit None - < aurlist.txt

# Set Default Browser
xdg-settings set default-web-browser firefox.desktop
echo "✓ Installation complete"
