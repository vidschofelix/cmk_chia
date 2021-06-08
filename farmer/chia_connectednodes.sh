#!/bin/bash
connections=$(docker exec chia venv/bin/chia show -c) # adjust this to your needs
state=$(docker exec chia venv/bin/chia show -s) # adjust this to your needs

ownheight=$(echo "${state}" | grep "Height:" | grep -v "Hash" | sed -r 's/.*Height:\s*([0-9]+).*$/\1/')

count=$(echo "${connections}" | grep "FULL_NODE" | wc -l)
sameheight=$(echo "${connections}" | grep "$ownheight" | wc -l)

if [[ -z "$count" ]]; then
  count=0
fi
echo "P \"Chia: Connected Full Nodes\" connections=$count;2:;0:|same_height=$sameheight $count Full Nodes Connected, $sameheight with same height"
