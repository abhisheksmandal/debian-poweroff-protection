#!/bin/bash
set -e

sudo mv /sbin/poweroff /sbin/poweroff.bak
sudo ln -s /bin/true /sbin/poweroff

sudo mv /sbin/halt /sbin/halt.bak
sudo ln -s /bin/true /sbin/halt

sudo mv /sbin/shutdown /sbin/shutdown.bak
sudo cp /sbin/shutdown.bak /sbin/shutdown
sudo chmod -x /sbin/shutdown

sudo systemctl mask poweroff.target halt.target shutdown.target
sudo systemctl unmask reboot.target

echo "Poweroff disabled, reboot still allowed."
