#!/bin/bash

set -ex 

vgchange -ay

APP_DEVICE_FS=`blkid -o value -s TYPE ${APP_DEVICE} || echo ""`
if [ "`echo -n $DEVICE_FS`" == "" ] ; then 
  # wait for the device to be attached
  DEVICENAME=`echo "${APP_DEVICE}" | awk -F '/' '{print $3}'`
  DEVICEEXISTS=''
  while [[ -z $DEVICEEXISTS ]]; do
    echo "checking $DEVICENAME"
    DEVICEEXISTS=`lsblk |grep "$DEVICENAME" |wc -l`
    if [[ $DEVICEEXISTS != "1" ]]; then
      sleep 15
    fi
  done
  pvcreate ${APP_DEVICE}
  vgcreate data ${APP_DEVICE}
  lvcreate --name volume1 -l 100%FREE data
  mkfs.ext4 /dev/data/volume1
fi

DEVICE_FS=`blkid -o value -s TYPE ${LOG_DEVICE} || echo ""`
if [ "`echo -n $DEVICE_FS`" == "" ] ; then
  # wait for the device to be attached
  DEVICENAME=`echo "${LOG_DEVICE}" | awk -F '/' '{print $3}'`
  DEVICEEXISTS=''
  while [[ -z $DEVICEEXISTS ]]; do
    echo "checking $DEVICENAME"
    DEVICEEXISTS=`lsblk |grep "$DEVICENAME" |wc -l`
    if [[ $DEVICEEXISTS != "1" ]]; then
      sleep 15
    fi
  done
  pvcreate ${LOG_DEVICE}
  vgcreate data ${LOG_DEVICE}
  lvcreate --name volume1 -l 100%FREE data
  mkfs.ext4 /dev/data/volume2
fi

mkdir -p /usr/local/apps
mkdir -p /var/log/applogs
if grep -q '/dev/data/volume1 /usr/local/apps ext4 defaults 0 0' /etc/fstab; then 
	echo
else
echo '/dev/data/volume1 /usr/local/apps ext4 defaults 0 0' >> /etc/fstab
fi
if grep -q '/dev/data/volume2 /var/log/applogs ext4 defaults 0 0' /etc/fstab; then
        echo
else
echo '/dev/data/volume2 /var/log/applogs ext4 defaults 0 0' >> /etc/fstab
fi


mount -a
