#!/bin/bash
# Installation script for HAPI Mouse Fix

# Update and install prerequisites
echo "Installing necessary packages..."
sudo apt update && sudo apt install -y evtest xinput zenity curl wget

# Check if evtest, xinput, and zenity are installed
if ! command -v evtest &> /dev/null; then
    echo "Error: evtest is not installed. Please check your package manager."
    exit 1
fi

if ! command -v xinput &> /dev/null; then
    echo "Error: xinput is not installed. Please check your package manager."
    exit 1
fi

if ! command -v zenity &> /dev/null; then
    echo "Error: zenity is not installed. Please check your package manager."
    exit 1
fi

echo "All necessary packages installed."

# Create the necessary directory for the mouse fix script
mkdir -p ~/.local/share/mousefixer

# Copy the mousefix.sh script to the local directory
cp mousefix.sh ~/.local/share/mousefixer/mousefix.sh
chmod +x ~/.local/share/mousefixer/mousefix.sh

# Add HAPIMOUSEFIX alias to .bashrc for all users
if ! grep -Fxq "alias HAPIMOUSEFIX='bash ~/.local/share/mousefixer/mousefix.sh'" ~/.bashrc
then
    echo "alias HAPIMOUSEFIX='bash ~/.local/share/mousefixer/mousefix.sh'" >> ~/.bashrc
    echo "Alias HAPIMOUSEFIX added to .bashrc."
fi

# Reload the bash configuration
source ~/.bashrc

# Finish
echo "HAPI Mouse Fix installation complete!"
echo "You can now use 'HAPIMOUSEFIX %command%' in your Steam launch options."
