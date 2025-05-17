#!/bin/bash
set -e

sudo rm -f /sbin/poweroff
sudo mv /sbin/poweroff.bak /sbin/poweroff

sudo rm -f /sbin/halt
sudo mv /sbin/halt.bak /sbin/halt

sudo rm -f /sbin/shutdown
sudo mv /sbin/shutdown.bak /sbin/shutdown
sudo chmod +x /sbin/shutdown

sudo systemctl unmask poweroff.target halt.target shutdown.target

echo "Poweroff restored."
