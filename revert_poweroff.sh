#!/bin/bash
set -euo pipefail

restore_cmd() {
    local cmd=$1
    local path="/sbin/$cmd"
    if [ -L "$path" ] && [ -e "$path.bak" ]; then
        sudo rm -f "$path"
        sudo mv "$path.bak" "$path"
        echo "$cmd restored."
    else
        echo "Warning: $cmd not restored (might not have been disabled)."
    fi
}

sudo -v

restore_cmd poweroff
restore_cmd halt

if [ -e /sbin/shutdown.bak ]; then
    sudo mv /sbin/shutdown.bak /sbin/shutdown
    sudo chmod +x /sbin/shutdown
    echo "shutdown restored."
else
    echo "shutdown.bak not found. Nothing to restore."
fi

sudo systemctl unmask poweroff.target halt.target shutdown.target

echo "✅ Poweroff, halt, shutdown restored."
