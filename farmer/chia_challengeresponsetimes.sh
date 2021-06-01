#!/bin/bash
logfile=/data/docker/chia/data/mainnet/log/debug.log # adjust this to your needs

minutes1=$(sed -n "/^$(date --date='60 seconds ago' '+%Y-%m-%dT%H:%M')/,\$p" $logfile | grep "were eligible for farming" | sed -E 's/^.*Time: ([0-9\.]+) s.*$/\1/gm;t;d')
minutes5=$(sed -n "/^$(date --date='5 minutes ago' '+%Y-%m-%dT%H:%M')/,\$p" $logfile | grep "were eligible for farming" | sed -E 's/^.*Time: ([0-9\.]+) s.*$/\1/gm;t;d')
minutes15=$(sed -n "/^$(date --date='15 minutes ago' '+%Y-%m-%dT%H:%M')/,\$p" $logfile | grep "were eligible for farming" | sed -E 's/^.*Time: ([0-9\.]+) s.*$/\1/gm;t;d')

function metric () {
        max=$(echo "$1" | sort -r | head -n 1)
        echo -n "$max;3;6"
}
lastvalue=$(echo -n "$minutes1" | head -n 1)
metric1=$(metric "$minutes1")
metric5=$(metric "$minutes5")
metric15=$(metric "$minutes15")


echo "P \"Chia: Challenge Responsetimes\" latest=$lastvalue|max1=$metric1|max5=$metric5|max15=$metric15 Harvester Max Challenge Responsetimes"
