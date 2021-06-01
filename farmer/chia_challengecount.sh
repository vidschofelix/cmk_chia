#!/bin/bash
debuglog=/data/docker/chia/data/mainnet/log/debug.log # adjust this to your needs

lastfullminute=$(date --date='60 seconds ago' '+%Y-%m-%dT%H:%M')
count=$(grep $lastfullminute $debuglog | grep "plots were eligible for farming" | wc -l)

echo "P \"Chia: Challenges last minute\" challgenges_per_minute=$count;5:;4:;0;10 $count challenges at $lastfullminute"
