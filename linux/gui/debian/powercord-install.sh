#!/bin/sh

# Grab Resouces and Prepare the Installer
cd /usr/share/icons/
wget --quiet "https://raw.githubusercontent.com/dream-frame/powercord-installer/master/resources/powercord.png"



# Auth
  while ! zenity --password  --ok-label="Continue"| sudo -S cat /dev/null >/dev/null; do
    if $(zenity --question --icon-name="powercord" --ellipsize --text="Wrong password, would you like to cancel the installation?"); then
      echo "no app-entry made, returning"
      zenity --warning --ellipsize --text="The installation was interrupted."
      return;
    fi
  done
    echo "$appEntry" | sudo -S tee ${launcher}

# Checking System Requirements
    (
        if ! [ -x "$(command -v git)" ]; then # Check if Git is installed
          echo "# Installing Git, please wait..."
          echo 'Git isn't installed. Installing Git... >&2
          sudo apt install git --yes
          sleep 1
        fi
            echo "Git is installed, skipping..."
        echo "100" ;
        if ! [ -x "$(command -v node)" ]; then # Check if node is installed
          echo "# Installing Node 12, please wait..."
          echo 'Node isn't installed. Installing Node... >&2
          sudo apt install build-essential apt-transport-https lsb-release ca-certificates curl  --yes
          curl --silent -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
          sudo apt install nodejs --yes
          sudo apt install npm --yes
          sleep 1
        fi
            echo "Node is installed, skipping..."

        if [ -x /usr/share/discord-canary ]; then
            echo "Discord Canary is installed, skipping..."
        else
            zenity --warning --text="Discord Canary isn't installed. Please quit the setup and install Discord Canary!"
            exit
        fi


        echo "# Powercord is ready, install now?" ;
        echo "100" ;
        exit
    ) |
    zenity --progress --title "Powercord Installer" \
    --text "Checking requirements..." --width="500" --percentage=0 --pulsate --ok-label="Yes" --cancel-label="No"


# Final - Install Powercord
    (
        echo "10" ;
        echo "# Cloning Powercord" ;
        cd ~ #Put Powercord in Home folder.
        git clone "https://github.com/powercord-org-/powercord/"

        echo "15" ;
        cd powercord

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
zenity --info --ellipsize --icon-name="powercord" --title="Job complete" --text="Finished installing."
sudo -K
clear
