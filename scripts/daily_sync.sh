#!/bin/bash

#1. Stop Better cap so we can log what was going on
sudo pkill bettercap
sleep 2
###verifes kill



#2. Convert Pcap to a readable text
tshark -r network_capture.pcap -T fields -e frame.time -e ip.src -e ip.dst -e _ws.col.Protocol > daily_summary.txt


# Convert my IP with INTERNAL

sed -i 's/192.168.56.1/INTERNAL_/g' daily_summary.txt


# 4 Git push 
git add daily_summary.txt
git commit -m "Network Log Update: $(date + '%Y-%m-%d')"
git push origin main


sudo bettercap -caplet monitor.cap &
