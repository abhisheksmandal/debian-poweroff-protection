#!/bin/bash
set -euo pipefail

disable_cmd() {
    local cmd=$1
    local path="/sbin/$cmd"
    if [ -e "$path" ] && [ ! -e "$path.bak" ]; then
        sudo mv "$path" "$path.bak"
        sudo ln -s /bin/true "$path"
        echo "$cmd disabled."
    elif [ -L "$path" ]; then
        echo "$cmd already disabled (symlink)."
    else
        echo "Warning: $cmd not found or already disabled."
    fi
}

sudo -v  # ask for sudo password upfront

disable_cmd poweroff
disable_cmd halt

# Special case for shutdown: just make it non-executable
if [ -e /sbin/shutdown ] && [ ! -e /sbin/shutdown.bak ]; then
    sudo cp /sbin/shutdown /sbin/shutdown.bak
    sudo chmod -x /sbin/shutdown
    echo "shutdown disabled (no exec)."
else
    echo "shutdown already disabled or backup exists."
fi

sudo systemctl mask poweroff.target halt.target shutdown.target
sudo systemctl unmask reboot.target

echo "✅ Poweroff, halt, shutdown disabled. Reboot still allowed."
