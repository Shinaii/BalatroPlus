#!/bin/bash

MOD_DIR="$(dirname "$0")"

TARGET_DIR=$(find ~/.steam/steam/steamapps/compatdata -type d -path "*/pfx/drive_c/users/steamuser/AppData/Roaming/Balatro/Mods" 2>/dev/null)

if [ -z "$TARGET_DIR" ]; then
    echo "Target directory not found.Please ensure Balatro is installed aswell as Lovely and SMODS."
    exit 1
fi

echo "Installing mod..."
cp -r "$MOD_DIR"/* "$TARGET_DIR"

echo "Mod installed successfully!"