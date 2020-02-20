#!/bin/bash
systemctl stop aktualizr-lite
systemctl disable aktualizr-lite
cp update.sh /sysroot/home/fio/update.sh
chmod a+x /sysroot/home/fio/update.sh
cp update.service /etc/systemd/system/update.service
systemctl enable update.service
aktualizr-lite update --update-name=11
reboot
