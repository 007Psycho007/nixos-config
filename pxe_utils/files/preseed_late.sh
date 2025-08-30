#!/bin/bash

curl -s http://10.200.4.12:8888/late_command.sh > /opt/late_command.sh
chmod 777 /opt/late_command.sh
chmod +x /opt/late_command.sh

# setup-autostart-terminal.sh
# This script configures your system to run a given script automatically
# in a terminal emulator window after user login.

# === CONFIGURATION ===
TARGET_SCRIPT="/opt/late_command.sh"     # Path to the script you want to run
TERMINAL="gnome-terminal"             # Change to xterm, konsole, xfce4-terminal, etc.
DESKTOP_FILE="$HOME/.config/autostart/late_command.desktop"
# =====================

# Ensure target script exists
if [ ! -f "$TARGET_SCRIPT" ]; then
  echo "Error: Script $TARGET_SCRIPT not found!"
  exit 1
fi

# Make sure target script is executable
chmod +x "$TARGET_SCRIPT"

# Ensure autostart directory exists
mkdir -p "$HOME/.config/autostart"

# Create the .desktop file
cat > "$DESKTOP_FILE" <<EOF
[Desktop Entry]
Type=Application
Name=Run Late_command
Exec=$TERMINAL -- $TARGET_SCRIPT
Terminal=false
X-GNOME-Autostart-enabled=true
EOF

echo "Autostart entry created at: $DESKTOP_FILE"
echo "Your script ($TARGET_SCRIPT) will run in $TERMINAL after login."
