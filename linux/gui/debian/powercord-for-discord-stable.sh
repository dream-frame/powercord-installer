#!/bin/sh

# Grab Resouces and Prepare the Installer
cd /usr/share/icons/
wget --quiet "https://raw.githubusercontent.com/dream-frame/powercord-installer/master/resources/powercord.png"
sleep 1
cd ~
wget --quiet "https://raw.githubusercontent.com/powercord-org/powercord/v2/LICENSE"

# License Agreement
cd ~
FILE=${HOME}/LICENSE

zenity --text-info \
       --width=548 \
       --height=461 \
       --title="License" \
       --filename=$FILE \
       --checkbox="I agree"

case $? in
    0)
        echo "Start installation! >:D"
	# next step
	;;
    1)
        echo "Stop installation! ;-; oh okay"
        exit
	;;
    -1)
        echo "An unexpected error has occurred."
        exit
	;;
esac

# Auth - Requires user to type in their password so that `sudo` can be used. Sudo is requires at the last command so Powercord can inject into Discord.
  while ! zenity --password| sudo -S cat /dev/null >/dev/null; do
    if $(zenity --question --icon-name="powercord" --ellipsize --text="Wrong password, would you like to cancel the installation?"); then
      echo "no app-entry made, returning"
      return;
    fi
  done
    echo "$appEntry" | sudo -S tee ${launcher}

# Checking System Requirements
# Powercord requires Git to update and Node to inject into Discord
## Check if Git is installed
if zenity --question --title="Powercord Installer" --icon-name="powercord" --ellipsize --ok-label="No" --cancel-label="Yes" --text="Do you have Git installed?"
then 
    (
        echo "0" ;
        sudo apt install git  --yes --quiet
        echo "99" ; 
        echo "# Git has been installed, click OK to continue." ; sleep 1
        echo "100" ;
    ) |
    zenity --progress --title "Powercord Installer" \
    --ellipsize --text "Installing Git, please wait..." --percentage=0 --pulsate
fi
    clear

## Check if Node v12 is installed
if zenity --question --title="Powercord Installer" --icon-name="powercord" --ellipsize --ok-label="No" --cancel-label="Yes" --text="Do you have Node 12 or up installed?"
then 
    (
        echo "25" ; sleep 1
        echo "# Install requirements for Node" ; sleep 1
        sudo apt install build-essential apt-transport-https lsb-release ca-certificates curl  --yes --quiet

        echo "50" ;
        curl --silent -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -

        echo "75" ; sleep 1
        echo "# Installing NodeJS" ; sleep 1
        sudo apt install nodejs --yes --quiet

        echo "95" ; sleep 1
        echo "# Injecting NPM" ; sleep 1
        sudo apt install npm --yes --quiet

        echo "99" ; sleep 3
        echo "# Done. Click OK to continue." ; sleep 1
        echo "100" ; sleep 1
    ) |
    zenity --progress --title "Powercord Installer" \
    --ellipsize --text "Preparing to install Node..." --percentage=0
fi
    clear

# Final - Install Powercord
    (
        echo "10" ; sleep 1
        echo "# Cloning Powercord" ; sleep 1
        cd ~ #Put Powercord in Home folder.
        git clone "https://github.com/dream-frame/powercord-for-discord-stable"

        echo "15" ; sleep 1
        cd powercord-for-discord-stable

        echo "75" ; sleep 1
        echo "# Installing components" ; sleep 1
        npm i

        echo "88" ; sleep 1
        echo "# Injecting Powercord" ; sleep 1
        sudo npm run plug

        echo "98" ; sleep 1
        echo "# Cleaning up..." ; sleep 3
        cd ~
        sudo rm LICENSE
        sleep 1
        cd /usr/share/icons/
        sudo rm powercord.png
        sleep 1

        echo "99" ; sleep 3
        echo "# Done. Click OK to continue." ; sleep 1
        echo "100" ; sleep 1
    ) |
zenity --progress --title "Powercord Installer" \
--width 500 --text "Preparing to install Powercord..." --percentage=0
clear
zenity --info --ellipsize --title="Job complete" --text="Finished installing."
sudo -K
clear
