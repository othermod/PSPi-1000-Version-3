#!/bin/bash
# This has been modified by otherMod from code written by Afafruit
# https://www.adafruit.com/
# http://www.othermod.com/

if [ $(id -u) -ne 0 ]; then
	echo "Installer must be run as root."
	echo "Try 'sudo bash $0'"
	exit 1
fi

echo "Looking for /boot/othermodoff.py"
if [ -e /boot/othermodoff.py ]; then
	echo "File exists. Continuing."
else
	echo "File doesn't exist."
	echo "Copy othermodoff.py to /boot/ and try again."
	echo "Failed."
	exit 1	
fi

grep othermodoff /etc/rc.local >/dev/null
if [ $? -eq 0 ]; then
	echo "othermodoff already exists in rc.local. Re-creating."
	# othermodoff already in rc.local, but make sure correct:
	sed -i "s/^.*othermodoff.*$/\python \/boot\/othermodoff.py \&/g" /etc/rc.local >/dev/null
else
	echo "othermodoff doesn't exist in rc.local. Creating."
	# Insert othermodoff into rc.local before final 'exit 0'
	sed -i "s/^exit 0/python \/boot\/othermodoff.py \&\\nexit 0/g" /etc/rc.local >/dev/null
fi
echo "Complete. Reboot is required."
	echo
echo "Reboot now? [y/n]"
read
if [[ "$REPLY" =~ ^(yes|y|Y)$ ]]; then
	echo "Rebooting..."
	reboot
#else
	echo
	echo "Done"
fi
