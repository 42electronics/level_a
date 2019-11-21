#!/bin/bash

reconfig() {
	grep $2 $1 >/dev/null
	if [ $? -eq 0 ]; then
		# Pattern found; replace in file
		sed -i "s|$2|$3|g" $1 >/dev/null
		echo "$1 updated"
	else
		# Not found; show error
		echo "Line to modify not found, $1 not changed"
	fi
}

reconfig /boot/config.txt "#hdmi_force_hotplug=1" "hdmi_force_hotplug=1"

# PROMPT FOR REBOOT --------------------------------------------------------

echo "Done."
echo
echo "Settings take effect on next boot."
echo
echo -n "REBOOT NOW? [y/N] "
read
if [[ ! "$REPLY" =~ ^(yes|y|Y)$ ]]; then
	echo "Exiting without reboot."
	exit 0
fi
echo "Reboot started..."
reboot
exit 0
