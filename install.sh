#!/bin/bash

MONGODBDIR=/data/mongodb3/

#sudo echo $MONGODBDIR > /tmp/mongodinit
#MONGODINIT= sudo cat /tmp/mongodinit | cut -d / -f3


if [ $# -eq 5 ]; then
  echo "You have entered the required arguments"
  echo "Validating if the directories already exit"
else
  echo "Enter five arguments"
  echo "The format is $0 <data dir> <log dir> <conf dir> <bin dir> <pid dir>"
exit 1
fi

DATA=$1
LOG=$2
CONF=$3
BIN=$4
PID=$5

#Create the required directories for running MongoDB based on directory names provided by a user
#The order of the directories provide is data for data  log for log conf for config bin for binary files and pid for process info


if [ -e $DATA ]; then
  echo "The directory $DATA already exists"
elif [ -e $LOG ]; then
  echo "The directory $LOG already exists"
elif [ -e $CONF ]; then
  echo "The directory $CONF already exists"
elif [ -e $BIN ]; then
  echo "The directory $BIN already exists"
elif [ -e $PID ]; then
  echo "The directory $PID already exists"
else
  echo "Creating the directories ... "
  sudo mkdir -p $MONGODBDIR/$DATA
  sudo mkdir -p $MONGODBDIR/$LOG
  sudo mkdir -p $MONGODBDIR/$CONF
  sudo mkdir -p $MONGODBDIR/$BIN
  sudo mkdir -p $MONGODBDIR/$PID

#Download MongoDB 3.0.11 from mongodb.org
#Extract the downloaded file and blace it under the mongodb bin directory

  sudo curl -o $MONGODBDIR/$BIN/mongodb-linux-x86_64.tgz  https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-rhel70-3.0.11.tgz
  sudo tar -zxf  $MONGODBDIR/$BIN/mongodb-linux-x86_64.tgz -C  /$MONGODBDIR/$BIN/ --strip-components=2

#Create MongoDB confirguration files

echo "dbpath=$MONGODBDIR/$DATA">>$MONGODBDIR/$CONF/mongod.conf
echo "logpath=$MONGODBDIR/$LOG/mongod.log">>$MONGODBDIR/$CONF/mongod.conf
echo "pidfilepath=$MONGODBDIR/$PID/mongod.pid">>$MONGODBDIR/$CONF/mongod.conf
echo "logappend=true">>$MONGODBDIR/$CONF/mongod.conf
echo "fork=true">>$MONGODBDIR/$CONF/mongod.conf
echo "port=40000">>$MONGODBDIR/$CONF/mongod.conf

#Run mongod process
  sudo /$MONGODBDIR/$BIN/mongod --config /$MONGODBDIR/$CONF/mongod.conf


#sudo curl -o /$MONGODBDIR/$CONF/$MONGODINIT https://raw.githubusercontent.com/esayasc/mongodb-install-script/master/mongod.init
#sudo chmod +x  /$MONGODBDIR/$CONF/$MONGODINIT


fi


