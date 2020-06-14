#!/bin/bash
 
while true
do
 read -r -p "Are you sure that you want to install Powercord? [Y/n] " input
 
 case $input in
     [yY][eE][sS]|[yY])
 echo "Preparing to install Powercord, checking requirements..."
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

 read -r -p "Do you have git installed? [Y/n] " git

 case $git in
     [yY][eE][sS]|[yY])
 echo "Skipping Git..."
 clear
 break
 ;;
     [nN][oO]|[nN])
 echo "Installing Git, please wait..."
 sudo apt install git --yes --quiet
 clear
 break
        ;;
     *)
 echo "Invalid input..."
 ;;
 esac
 
 
 
 read -r -p "Do you curl installed? [Y/n] " curl
    
     case $curl in
         [yY][eE][sS]|[yY])
     echo "Skipping curl..."
     clear
     break
     ;;
         [nN][oO]|[nN])
     echo "Installing curl, please wait..."
     sudo apt install curl --yes --quiet
     clear
     break
            ;;
         *)
     echo "Invalid input..."
     ;;
     esac
 
 
  read -r -p "Do you have Node v12 installed? [Y/n] " node
 
  case $node in
      [yY][eE][sS]|[yY])
  echo "Skipping Node..."
  clear
  break
  ;;
      [nN][oO]|[nN])
  echo "Installing Node, please wait..."
  sudo apt install build-essential apt-transport-https lsb-release ca-certificates curl  --yes --quiet
  curl --silent -sL https://deb.nodesource.com/setup_12.x | sudo -E bash - 
  sudo apt install nodejs --yes --quiet
  clear
  break
         ;;
      *)
  echo "Invalid input..."
  ;;
  esac
  
    read -r -p "Powercord is ready to install, inject now? [Y/n] " installPowercord
   
    case $installPowercord in
        [yY][eE][sS]|[yY])
    cd ~
    git clone https://github.com/powercord-org/powercord --quiet
    sudo chmod -R 777 powercord
    cd powercord
    npm i --silent
    echo "Showing output for last command to confirm installation:"
    sudo npm run plug
    echo "Done."
    break
    ;;
        [nN][oO]|[nN])
    echo ";-; that's sad"
    exit
    break
           ;;
        *)
    echo "Invalid input..."
    ;;
    esac