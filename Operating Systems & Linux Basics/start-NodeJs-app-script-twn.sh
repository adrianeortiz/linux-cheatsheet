#!/bin/bash

# prepare environment, install all tools
apt update

echo "install node, npm, curl, wget, net-tools"
apt install -y nodejs npm curl net-tools  
sleep 15
echo ""
echo "################"
echo ""

# read user input for log directory
echo -n "Set log directory location for the application (absolute path): "
read LOG_DIRECTORY
if [ -d $LOG_DIRECTORY ]
then
  echo "$LOG_DIRECTORY already exists"
else
  mkdir -p $LOG_DIRECTORY
  echo "A new directory $LOG_DIRECTORY has been created"
fi

# display nodeJS version
node_version=$(node --version)
echo "NodeJS version $node_version installed"

# display npm version
npm_version=$(npm --version)
echo "NPM version $npm_version installed"

echo ""
echo "################"
echo ""

# fetch NodeJS project archive from s3 bucket
wget https://node-envvars-artifact.s3.eu-west-2.amazonaws.com/bootcamp-node-envvars-project-1.0.0.tgz

# extract the project archive to ./package folder
tar zxvf ./bootcamp-node-envvars-project-1.0.0.tgz

# set all needed environment variables
export APP_ENV=dev
export DB_PWD=mysecret
export DB_USER=myuser 

# change to package directory
cd package

# install application dependencies
npm install

# start the nodejs application in the background
node server.js &

# display that nodejs process is running
ps aux | grep node | grep -v grep

# display that nodejs is running on port 3000
netstat -ltnp | grep :3000
