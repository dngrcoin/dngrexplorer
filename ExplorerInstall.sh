#!/bin/bash

# Simple script for install dangrexplorer from sudo user
sudo apt-get update && sudo apt-get upgrade
sudo apt-get install mc nano git pwgen libkrb5-dev curl apt-transport-https htop

#install dngrcoind
wget https://raw.githubusercontent.com/dngrcoin/dngrcoin/master/DNGRinstall.sh
bash DNGRinstall.sh
sudo ufw allow 80

#Install MongoDB latest version on Ubuntu
wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.2.list
sudo apt-get update
sudo apt-get install -y mongodb-org
sudo systemctl enable mongod

#Installing Nodejs
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt-get install -y nodejs


#Installing the Explorer
git clone https://github.com/dngrcoin/dngrexplorer.git explorer
cd explorer && npm install --production
cp ./settings.json.template ./settings.json

#Install Forever to keep the js running
cd
sudo npm install forever -g
sudo npm install forever-monitor

# End manuall install
#sudo reboot
#Creating a MongoDB Database
# mongo
#> use explorerdb
#> db.createUser( { user: "67788uh", pwd: "kjh675sdf34", roles: [ "readWrite" ] } )
#> exit

#Modify the Settings File
# sudo nano settings.json

#crontab -e
#@reboot sleep 2 && /home/danger/dngrcoind -daemon -txindex 
#sudo crontab -e
#*/1 * * * * cd /home/danger/explorer && /usr/bin/nodejs scripts/sync.js index update > /dev/null 2>&1
#*/2 * * * * cd /home/danger/explorer && /usr/bin/nodejs scripts/sync.js market > /dev/null 2>&1
#*/5 * * * * cd /home/danger/explorer && /usr/bin/nodejs scripts/peers.js > /dev/null 2>&1
#@reboot sleep 45; cd /home/danger/explorer && forever start bin/cluster
