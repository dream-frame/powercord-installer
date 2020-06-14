#!/bin/sh

# Introduction to Powercord

# Checking System Requirements
## Check if Git is installed
if zenity --question --ok-label="No" --cancel-label="Yes" --text="Do you have Git installed?"
then 
    clear
    echo "Installing git..."
    sleep 2s
    sudo apt install git --yes --quiet
    clear
    echo "Git is now installed."
    sleep 2s
fi
    clear

## Check if Curl is installed
if zenity --question --ok-label="No" --cancel-label="Yes" --text="Do you have Curl installed?"
then 
    clear
    echo "Installing curl..."
    sleep 2s
    sudo apt install curl --yes --quiet
    clear
    echo "Curl is now installed."
    sleep 2s
fi
    clear

## Check if Node v12 is installed
if zenity --question --ok-label="No" --cancel-label="Yes" --text="Do you have Node v12 or up installed?"
then 
    clear
    echo "Installing node..."
    sleep 2s
    sudo apt install build-essential apt-transport-https lsb-release ca-certificates curl  --yes --quiet
    curl --silent -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
    sudo apt install nodejs --yes --quiet
    sudo apt install npm --yes --quiet
    clear
    echo "Node is now installed."
    sleep 2s
fi
    clear

# Final - Install Powercord
(
echo "10" ; sleep 1
echo "# Cloning Powercord" ; sleep 1
git clone "https://github.com/dream-frame/powercord-for-discord-stable"
echo "15" ;
cd powercord-for-discord-stable
echo "75" ; sleep 1
echo "# Installing components" ; sleep 1
npm i
echo "95" ; sleep 1
echo "# Injecting Powercord" ; sleep 1
sudo npm run plug
echo "98" ; sleep 1
echo "# Cleaning up..." ; sleep 3
echo "99" ; sleep 3
echo "# Done. Click OK to continue." ; sleep 1
echo "100" ; sleep 1
) |
zenity --progress --title "Powercord Installer" \
--width 500 --text "Preparing to install Powercord..." --percentage=0
clear
zenity --info --width 300 --title="Job complete" --text="Finished installing."
clear
