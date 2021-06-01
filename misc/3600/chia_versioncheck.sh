#!/bin/bash
running=$(docker exec plotman bash -c "venv/bin/chia version") # adjust to your local "chia version" command
latest=$(curl --silent "https://api.github.com/repos/Chia-Network/chia-blockchain/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
if [[ $latest == $running ]]
then
  echo 0 \"Chia: Running Version\" - $running
else
  echo 2 \"Chia: Running Version\" - Latest Version $latest not installed  \(running $running\)
fi
