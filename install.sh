#!/bin/bash
systemctl stop aktualizr-lite
systemctl disable aktualizr-lite
cp update.sh /sysroot/home/fio/update.sh
cp DEMO_START /sysroot/home/fio/DEMO_START
cp DEMO_STOP /sysroot/home/fio/DEMO_STOP
chmod a+x /sysroot/home/fio/update.sh
chmod a+x /sysroot/home/fio/DEMO_START
chmod a+x /sysroot/home/fio/DEMO_STOP
cp update.service /etc/systemd/system/update.service
systemctl enable update.service
aktualizr-lite update --update-name=11
reboot
