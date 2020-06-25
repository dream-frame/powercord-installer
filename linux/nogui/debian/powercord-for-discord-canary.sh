#!/bin/bash
 
while true
do
 read -r -p "Do you want to continue? [Y/n] " input
 
 case $input in
     [yY][eE][sS]|[yY])
 echo "Preparing to install Powercord, checking requirements..."
         if ! [ -x "$(command -v git)" ]; then # Check if Git is installed
         clear
          echo "# Installing Git, please wait..."
          echo "Git is not installed. Installing Git..." >&2
          sudo apt install git --yes
          sleep 1
        fi
            clear
            echo "Git is installed, skipping..."
            sleep 1
            clear
        if ! [ -x "$(command -v node)" ]; then # Check if node is installed
          echo "# Installing Node 12, please wait..."
          echo "Node is not installed. Installing Node..." >&2
          sudo apt install build-essential apt-transport-https lsb-release ca-certificates curl  --yes
          curl --silent -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
          sudo apt install nodejs --yes
          sudo apt install npm --yes
          sleep 1
        fi
            echo "Node is installed, skipping..."
            sleep 1
            clear
        if [ -x /usr/share/discord-canary ]; then
            echo "Discord Canary is installed, skipping..."
            sleep 1
            clear
                    else
            tput setaf 1; echo "Please stop the setup!"
            tput setaf 1; echo "Discord Canary isn't installed. Please quit the setup and install Discord Canary!"
            sleep 120
        fi
 clear
 break
 ;;
     [nN][oO]|[nN])
 echo ";-; alright"
 exit
 break
        ;;
     *)
 echo "Invalid input..."
 ;;
 esac
 done

cd ~
git clone https://github.com/powercord-org/powercord
cd powercord
npm i
npm run plug