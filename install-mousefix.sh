#!/bin/bash

# Function to disable problematic repositories
disable_problematic_repos() {
    echo "Checking for problematic repositories..."

    # Check and disable rael-gc/ubuntu-xboxdrv PPA
    if grep -q "^deb .*rael-gc/ubuntu-xboxdrv" /etc/apt/sources.list /etc/apt/sources.list.d/*; then
        echo "Disabling rael-gc/ubuntu-xboxdrv PPA..."
        sudo rm /etc/apt/sources.list.d/rael-gc-ubuntu-xboxdrv-noble.list 2>/dev/null
        sudo rm /etc/apt/sources.list.d/rael-gc-ubuntu-xboxdrv-focal.list 2>/dev/null
    fi

    # Check and disable apt.packages.shiftkey.dev repo
    if grep -q "^deb .*apt.packages.shiftkey.dev" /etc/apt/sources.list /etc/apt/sources.list.d/*; then
        echo "Disabling apt.packages.shiftkey.dev repository..."
        sudo rm /etc/apt/sources.list.d/shiftkey-packages.list 2>/dev/null
    fi
}

# Function to install necessary packages
install_packages() {
    echo "Installing necessary packages..."

    # Update and install required packages
    sudo apt update
    sudo apt install -y evtest xinput zenity curl wget

    # Check if the packages were installed successfully
    if ! command -v evtest &> /dev/null; then
        zenity --error --title="Installation Error" --text="Error: evtest is not installed. Please check your package manager."
        exit 1
    fi

    if ! command -v xinput &> /dev/null; then
        zenity --error --title="Installation Error" --text="Error: xinput is not installed. Please check your package manager."
        exit 1
    fi

    if ! command -v zenity &> /dev/null; then
        zenity --error --title="Installation Error" --text="Error: zenity is not installed. Please check your package manager."
        exit 1
    fi

    echo "All necessary packages installed."
}

# Function to set up the HAPIMOUSEFIX script
setup_mousefix_script() {
    echo "Setting up HAPIMOUSEFIX..."

    # Create necessary directories
    mkdir -p ~/.local/share/mousefixer

    # Copy the mousefix.sh script to the local directory
    cp mousefix.sh ~/.local/share/mousefixer/mousefix.sh
    chmod +x ~/.local/share/mousefixer/mousefix.sh

    # Add HAPIMOUSEFIX alias to .bashrc if not already present
    if ! grep -Fxq "alias HAPIMOUSEFIX='bash ~/.local/share/mousefixer/mousefix.sh'" ~/.bashrc; then
        echo "alias HAPIMOUSEFIX='bash ~/.local/share/mousefixer/mousefix.sh'" >> ~/.bashrc
        echo "Alias HAPIMOUSEFIX added to .bashrc."
    fi

    # Reload the bash configuration
    source ~/.bashrc

    echo "HAPIMOUSEFIX setup complete!"
    echo "You can now use 'HAPIMOUSEFIX %command%' in your Steam launch options."
}

# Main installation process
disable_problematic_repos
install_packages
setup_mousefix_script

# Finish installation
zenity --info --title="Installation Complete" --text="HAPIMOUSEFIX installation completed successfully!"
