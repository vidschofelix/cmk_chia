#!/bin/bash
farmsummary=$(docker exec chia venv/bin/chia farm summary) # adjust this to your chia farm summary command
statustext=$(echo "${farmsummary}" | awk -F: '/Farming status/ {print $2}' | sed 's/^ *//g')
if [[ "${statustext}" == "Farming" ]]; then
  echo "0 \"Chia: Farming status\" - $statustext"
else
  echo "2 \"Chia: Farming status\" - $statustext"
fi

##xch farmed
farmed=$(echo "${farmsummary}" | awk -F: '/Total chia farmed/ {print $2}' | sed 's/^ *//g')
if [ -z $(echo ${farmed} | grep -E "[0-9].*") ]; then
  echo "2 \"Chia: Total farmed\" count=$farmed $farmed"
else
  echo "0 \"Chia: Total farmed\" count=$farmed $farmed"
fi

##plot count
plots=$(echo "${farmsummary}" | awk -F: '/Plot count/ {print $2}' | sed 's/^ *//g')
if [ -z $(echo ${plots} | grep -E "[0-9].*") ]; then
  echo "2 \"Chia: Plot count\" count=$plots $plots"
else
  echo "0 \"Chia: Plot count\" count=$plots $plots"
fi

##days to win
ettw=$(echo "${farmsummary}" | awk -F: '/Expected time to win/ {print $2}' | sed 's/^ *//g' | sed 's/and //g')
days=$((($(date +%s -d "$ettw") - $(date +%s)) / (3600 * 24)))
if [ -z $(echo ${days} | grep -E "[0-9].*") ]; then
  echo "2 \"Chia: Expected days to win\" count=$days $days days"
else
  echo "0 \"Chia: Expected days to win\" count=$days $days days"
fi
