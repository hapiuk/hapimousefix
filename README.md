# HAPIMOUSEFIX



**HAPIMOUSEFIX** is a simple tool designed to address mouse sensitivity issues in games like **Metro 2033 Redux**, which often have inconsistent sensitivity settings between horizontal and vertical mouse movements due to poor PC porting. The script dynamically adjusts the mouse sensitivity based on the detected polling rate, providing a smoother gaming experience.



## Problem Background

Many PC games, particularly those originally developed for consoles, suffer from mouse sensitivity inconsistencies. For example, in **Metro 2033 Redux**, users experience drastically different horizontal and vertical sensitivity, making gameplay feel uneven. This project was created to solve such issues, starting with Metro 2033 Redux but can be used universally for other games.



## Features

- **Automatic Polling Rate Detection**: Detects the mouse polling rate using `evtest` and applies sensitivity adjustments accordingly.

- **Sensitivity Fix**: Adjusts mouse sensitivity dynamically, improving horizontal and vertical movement balance.

- **Zenity Notifications**: Provides pop-up messages to confirm the polling rate and applied sensitivity fixes.



## Requirements

Before installing **HAPIMOUSEFIX**, ensure you have **GameMode** installed:

\`\`\`bash

sudo apt install gamemode

\`\`\`



**Additional Packages**:

- `evtest`: For detecting mouse polling rate.

- `xinput`: For dynamically adjusting mouse sensitivity.

- `zenity`: For displaying pop-up notifications.

- `curl` and `wget`: Optional, for downloading dependencies.



## Installation

To install HAPIMOUSEFIX, follow these steps:



1. Clone the repository:

\`\`\`bash

git clone https://github.com/hapiuk/hapimousefix.git

cd hapimousefix

\`\`\`



2. Run the installation script:

\`\`\`bash

bash install-mousefix.sh

\`\`\`



The script will:

- Install the required packages (`evtest`, `xinput`, `zenity`, `curl`, and `wget`).

- Disable problematic repositories such as `apt.packages.shiftkey.dev` and `rael-gc/ubuntu-xboxdrv` to ensure smooth package installation.

- Set up the `HAPIMOUSEFIX` alias in `.bashrc` for easy use.



## Usage

Once installed, you can easily apply the mouse fix by adding the following to your **Steam launch options** for any game:

\`\`\`

HAPIMOUSEFIX %command%

\`\`\`



This will:

- Automatically adjust mouse sensitivity based on polling rate before the game starts.

- Reset the mouse sensitivity to its default value when the game ends.

- Display notifications about the polling rate and sensitivity settings using Zenity.



## Warnings

During installation, you may encounter GTK-related warnings, such as:

\`\`\`

(zenity:xxxx): Gtk-WARNING **: Unknown key gtk-modules in ~/.config/gtk-4.0/settings.ini

(zenity:xxxx): Adwaita-WARNING **: Using GtkSettings:gtk-application-prefer-dark-theme with libadwaita is unsupported.

\`\`\`

These warnings are non-critical and can be safely ignored unless they affect functionality. They are related to the GTK settings being used in the system, particularly with dark themes.



## Uninstalling

To uninstall HAPIMOUSEFIX and remove all associated files:



1. Remove installed packages:

\`\`\`bash

sudo apt remove --purge evtest xinput zenity curl wget -y

sudo apt autoremove --purge -y

\`\`\`



2. Delete the mouse fix script:

\`\`\`bash

rm -rf ~/.local/share/mousefixer/

\`\`\`



3. Remove the alias from `.bashrc`:

\`\`\`bash

nano ~/.bashrc

# Remove the line: alias HAPIMOUSEFIX='bash ~/.local/share/mousefixer/mousefix.sh'

source ~/.bashrc

\`\`\`



## License

This project is open-source and available under the [MIT License](LICENSE).



## Credits

This project makes use of the following tools:

- [evtest](https://manpages.ubuntu.com/manpages/focal/man1/evtest.1.html)
- [xinput](https://manpages.ubuntu.com/manpages/focal/man1/xinput.1.html)
- [zenity](https://manpages.ubuntu.com/manpages/focal/man1/zenity.1.html)