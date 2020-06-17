#!/bin/sh

# Grab Resouces and Prepare the Installer
cd /usr/share/icons/
wget --quiet "https://raw.githubusercontent.com/dream-frame/powercord-installer/master/resources/powercord.png"



# Auth
  while ! zenity --password| sudo -S cat /dev/null >/dev/null; do
    if $(zenity --question --icon-name="powercord" --ellipsize --text="Wrong password, would you like to cancel the installation?"); then
      echo "no app-entry made, returning"
      return;
    fi
  done
    echo "$appEntry" | sudo -S tee ${launcher}

# Checking System Requirements
    (
        if ! [ -x "$(command -v git)" ]; then # Check if Git is installed
          echo 'Git isn't installed. Installing Git... >&2
          sudo apt install git
          exit 1
        fi
            echo "Git is installed, skipping..."
        echo "100" ;
        if ! [ -x "$(command -v node)" ]; then # Check if node is installed
          echo 'Git isn't installed. Installing Git... >&2
          sudo apt install git
          exit 1
        fi
            echo "Git is installed, skipping..."
        echo "# Click Continue." ;
        echo "100" ;
    ) |
    zenity --progress --title "Powercord Installer" \
    --text "Checking requirements..." --percentage=0 --pulsate --ok-label="Continue"


# Final - Install Powercord
    (
        echo "10" ;
        echo "# Cloning Powercord" ;
        cd ~ #Put Powercord in Home folder.
        git clone "https://github.com/dream-frame/powercord-for-discord-stable"

        echo "15" ;
        cd powercord-for-discord-stable

        echo "75" ;
        echo "# Installing components" ;
        npm i

        echo "88" ;
        echo "# Injecting Powercord" ;
        sudo npm run plug

        echo "98" ;
        echo "# Cleaning up..." ;
        cd /usr/share/icons/
        sudo rm powercord.png

        echo "99" ;
        echo "# Done. Click OK to continue." ;
        echo "100" ;
    ) |
zenity --progress --title "Powercord Installer" \
--width 500 --text "Preparing to install Powercord..." --percentage=0
clear
zenity --info --ellipsize --title="Job complete" --text="Finished installing."
sudo -K
clear
