#!/bin/bash

sleep 60

echo "UPDATER: Initialization sequence started" | tee -a /dev/console

sleep 20

echo "UPDATER: Checking update counter" | tee -a /dev/console

counter=0

if test -f "/sysroot/home/fio/counter"; then
	echo "UPDATER: Previous updates detected" | tee -a /dev/console
	counter=$(cat /sysroot/home/fio/counter)
	echo "UPDATER: Update count at $counter" | tee -a /dev/console
else
	echo "UPDATER: No previous updates detected" | tee -a /dev/console
	echo "UPDATER: Update count set to 0" | tee -a /dev/console
fi

sleep 20

active_image=$(aktualizr-lite status | grep 'Active image is:' | cut -d ':' -f 2 | cut -f 1 | xargs)
echo "UPDATER: The active image is: $active_image" | tee -a /dev/console

if test -f "/sysroot/home/fio/kver"; then
	echo "UPDATER: The Linux kernel version has changed from: $(cat /sysroot/home/fio/kver) to $(uname -r)" | tee -a /dev/console
	echo $(uname -r) > /sysroot/home/fio/kver
else
	echo "UPDATER: The Linux kernel version is: $(uname -r)" | tee -a /dev/console
	echo $(uname -r) > /sysroot/home/fio/kver
fi

sleep 20

if [ "$active_image" = "11" ]; then
	echo "UPDATER: Downgrading to image: 8" | tee -a /dev/console
	aktualizr-lite update --update-name=8 | tee -a /dev/console
	echo "UPDATER: Image 8 has been applied successfully" | tee -a /dev/console
	sleep 20
	echo "UPDATER: Rebooting device to apply update" | tee -a /dev/console
	counter=$((counter+1))
	echo $counter > /sysroot/home/fio/counter
	reboot
else
	echo "UPDATER: Upgrading to image: 11" | tee -a /dev/console
	aktualizr-lite update --update-name=11 | tee -a /dev/console
        echo "UPDATER: Image 11 has been applied successfully" | tee -a /dev/console
	sleep 20
	echo "UPDATER: Rebooting device to apply update" | tee -a /dev/console
        counter=$((counter+1))
        echo $counter > /sysroot/home/fio/counter
	reboot
fi
