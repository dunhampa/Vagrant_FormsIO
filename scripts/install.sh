#!/bin/bash
set -x

#Variables
#IP_HOST is the network setup in vagranfile
IP_HOST=192.168.199.9


#Node install fixed to 8.5
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install -y nodejs

#Mongo
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.0.list
sudo apt-get update
sudo apt-get install -y mongodb-org=4.0.5 mongodb-org-server=4.0.5 mongodb-org-shell=4.0.5 mongodb-org-mongos=4.0.5 mongodb-org-tools=4.0.5
echo "mongodb-org hold" | sudo dpkg --set-selections
echo "mongodb-org-server hold" | sudo dpkg --set-selections
echo "mongodb-org-shell hold" | sudo dpkg --set-selections
echo "mongodb-org-mongos hold" | sudo dpkg --set-selections
echo "mongodb-org-tools hold" | sudo dpkg --set-selections

#Start mongod even though this doesn't work
#mongod 

#Git Forms IO
git clone https://github.com/formio/formio.git --depth=1

#Config file in formio install
sudo cp /vagrant/default.json  /home/vagrant/formio/config/default.json
sudo sed -i 's/IP_REPLACE/'"$IP_HOST"'/g' /home/vagrant/formio/config/default.json

#Install npm in formio directory
sudo npm install ./formio/ --unsafe-perm=true --allow-root
#Create directory for mongo
sudo mkdir -p /data/db

