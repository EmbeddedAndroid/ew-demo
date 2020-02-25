#!/bin/bash

sleep 80

echo "" | tee -a /dev/console
echo "---------------------------------------------------------------" | tee -a /dev/console
echo "UPDATER DEMO: Update initialization sequence started" | tee -a /dev/console
echo "---------------------------------------------------------------" | tee -a /dev/console
echo "" | tee -a /dev/console
echo "---------------------------------------------------------------" | tee -a /dev/console
echo "UPDATER DEMO: Checking update counter" | tee -a /dev/console
echo "---------------------------------------------------------------" | tee -a /dev/console
echo "" | tee -a /dev/console

counter=0

echo "---------------------------------------------------------------" | tee -a /dev/console
if test -f "/sysroot/home/fio/counter"; then
	echo "UPDATER DEMO: Previous updates detected" | tee -a /dev/console
	counter=$(cat /sysroot/home/fio/counter)
	echo "UPDATER DEMO: Update count is $counter" | tee -a /dev/console
	echo "---------------------------------------------------------------" | tee -a /dev/console
	echo "" | tee -a /dev/console
else
	echo "---------------------------------------------------------------" | tee -a /dev/console
	echo "UPDATER DEMO: No previous updates detected" | tee -a /dev/console
	echo "UPDATER DEMO: Update count set to 0" | tee -a /dev/console
	echo "---------------------------------------------------------------" | tee -a /dev/console
	echo "" | tee -a /dev/console
fi

sleep 5

active_image=$(aktualizr-lite status | grep 'Active image is:' | cut -d ':' -f 2 | cut -f 1 | xargs)
echo "---------------------------------------------------------------" | tee -a /dev/console
echo "UPDATER DEMO: The active image is FoundriesFactory build: $active_image" | tee -a /dev/console
echo "---------------------------------------------------------------" | tee -a /dev/console
echo "" | tee -a /dev/console

echo "---------------------------------------------------------------" | tee -a /dev/console
echo "UPDATER DEMO: The Linux kernel version is: $(uname -r)" | tee -a /dev/console
echo $(uname -r) > /sysroot/home/fio/kver
echo "---------------------------------------------------------------" | tee -a /dev/console
echo "" | tee -a /dev/console

sleep 5

if [ "$active_image" = "46" ]; then
	echo "---------------------------------------------------------------" | tee -a /dev/console
	echo "UPDATER DEMO: Now changing to Weston accelerated graphics" | tee -a /dev/console
	echo "FoundriesFactory build: 33" | tee -a /dev/console
	echo "---------------------------------------------------------------" | tee -a /dev/console
	echo "" | tee -a /dev/console
	aktualizr-lite update --update-name=33 | tee -a /dev/console
	echo "" | tee -a /dev/console
	echo "---------------------------------------------------------------" | tee -a /dev/console
	echo "UPDATER DEMO: Image 33 has been installed successfully" | tee -a /dev/console
	echo "---------------------------------------------------------------" | tee -a /dev/console
	echo "" | tee -a /dev/console
	sleep 2
	echo "---------------------------------------------------------------" | tee -a /dev/console
	echo "UPDATER DEMO: Rebooting device to apply update" | tee -a /dev/console
	echo "---------------------------------------------------------------" | tee -a /dev/console
	echo "" | tee -a /dev/console
	counter=$((counter+1))
	echo $counter > /sysroot/home/fio/counter
	sleep 2
	reboot
else
	echo "---------------------------------------------------------------" | tee -a /dev/console
	echo "UPDATER DEMO: Now Changing to upstream frame buffer graphics" | tee -a /dev/console
	echo "FoundriesFactory build: 46" | tee -a /dev/console
	echo "---------------------------------------------------------------" | tee -a /dev/console
	echo "" | tee -a /dev/console
	aktualizr-lite update --update-name=46 | tee -a /dev/console
	echo "" | tee -a /dev/console
	echo "---------------------------------------------------------------" | tee -a /dev/console
        echo "UPDATER DEMO: Image 46 has been installed successfully" | tee -a /dev/console
	echo "---------------------------------------------------------------" | tee -a /dev/console
	echo "" | tee -a /dev/console
	sleep 2
	echo "---------------------------------------------------------------" | tee -a /dev/console
	echo "UPDATER DEMO: Rebooting device to apply update" | tee -a /dev/console
	echo "---------------------------------------------------------------" | tee -a /dev/console
	echo "" | tee -a /dev/console
        counter=$((counter+1))
        echo $counter > /sysroot/home/fio/counter
	sleep 2
	reboot
fi
