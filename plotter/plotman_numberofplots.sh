status=$(docker exec plotman bash -c ". ./activate && plotman status" 2>/dev/null | grep -ve "stty")

jobs=$(echo "$status" | head -n-1 | wc -l)
if [[ $jobs -gt 0 ]]; then
  return=0
else
  return=2
fi
echo -n $return \"Chia: Plotman Active Plots\" count=$jobs $jobs active plots\\n
printf '%b\n' "${status}" | sed -z 's/\n/\\n/g'
echo "\n"
