#!/bin/bash

function getLanIp {
    found=0
    i=0
    ip="Not connected to LAN"
    tmpFile="/tmp/actIP"
    while [[ $found == 0 && $i < 5 ]]; do
        ipconfig getifaddr en$i 2>/dev/null > $tmpFile
        if [[ $? == 0 ]]; then
            ip=$(cat $tmpFile)
            found=1
        fi
        i=$(($i + 1))
    done

    rm $tmpFile
    echo $ip
}

wifiStat=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I \
    | grep -o '[^B]SSID: [^\n]\+' || echo "No WiFi connection")


echo "Network:"
echo "    WiFi: $wifiStat"
echo "    Local IP: $(getLanIp)"

exit 0
