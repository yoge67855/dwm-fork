dte(){
  dte="$(date +"%d %B %H:%M:%S")"
  echo "$dte"
}

mem(){
  mem=`free -m | awk '/Pamięć:/ {printf "%dMB / %dMB\n", $3, $2 }'`
  echo  "MEM: $mem"
}

cpu(){
  read cpu a b c previdle rest < /proc/stat
  prevtotal=$((a+b+c+previdle))
  sleep 0.5
  read cpu a b c idle rest < /proc/stat
  total=$((a+b+c+idle))
  cpu=$((100*( (total-prevtotal) - (idle-previdle) ) / (total-prevtotal) ))
  echo "CPU: $cpu%"
}

bat(){
  bat=`cat /sys/class/power_supply/BAT0/capacity`
  echo "B: $bat%"
}

#while true; do
xsetroot -name "$(cpu) | $(mem)| $(bat) | $(dte)"
#     sleep 10s    # Update time every ten seconds
#done &

