#!/bin/bash

cd "$(dirname "$0")"

IP=$(ip route | grep -E "dev enx.*src 10\." | awk '{for(i=1;i<=NF;i++) if($i=="src") print $(i+1)}' | head -n 1)

if [ -z "$IP" ]; then
    notify-send "Network None" "No IP Connected." -i dialog-warning
    killall networktablet
    sleep 1
    notify-send "GFX Server" "Stoped." -i dialog-information
else
    notify-send "Network Info" "Now IP: $IP" -i network-transmit-receive
    if ! pgrep -x "networktablet" > /dev/null; then
        ./networktablet &
        sleep 1
        notify-send "GFX Server" "Working Now..." -i dialog-information
    else
        notify-send "GFX Server" "Already Working." -i dialog-information
    fi
fi
