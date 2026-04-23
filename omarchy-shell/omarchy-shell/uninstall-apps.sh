#!/bin/bash
# uninstall-apps.sh
# Removes Omarchy default presets and cleans the system

set -e  # Exit on error

echo "========================================="
echo "   UNINSTALLING OMARCHY PRESETS"
echo "========================================="

# --- Remove All Presets ---
# This uses the built-in omarchy command to drop pre-installed apps
if command -v omarchy-pkg-drop &> /dev/null; then
    echo "Running Omarchy preset removal..."
    # 'all' is the argument used by omarchy to target pre-installed groups
    omarchy-pkg-drop all
    echo "✓ Presets removed"
else
    echo "⊘ omarchy-pkg-drop command not found. Are you on an Omarchy system?"
fi

# --- Clean up orphaned dependencies ---
# We store the list in a variable first to check if it's empty
ORPHANS=$(pacman -Qtdq)

echo -e "\nCleaning up orphaned packages..."
if [ -n "$ORPHANS" ]; then
    echo "$ORPHANS" | sudo pacman -Rns - --noconfirm
else
    echo "No orphaned packages to remove."
fi

# --- Clean package cache ---
echo "Cleaning package cache..."
sudo pacman -Sc --noconfirm

echo ""
echo "========================================="
echo "  ✓ UNINSTALLATION COMPLETE"
echo "========================================="
echo ""


