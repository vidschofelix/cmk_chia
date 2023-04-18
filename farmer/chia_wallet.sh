#!/bin/bash
wallet=$(docker exec chia venv/bin/chia wallet show) # adjust this to your needs)
input_str=$(echo $wallet | grep "\-Total Balance" | head -1)
regex="\s*-Total Balance:\s+([0-9.]+)\s+xch\s"
if [[ $input_str =~ $regex ]]; then
  balance=${BASH_REMATCH[1]}
  balance=$(LC_NUMERIC="en_US.UTF-8" printf "%.2f" $balance)
  echo "0 \"Chia: Wallet total balance\" count=$balance $balance XCH"
fi
