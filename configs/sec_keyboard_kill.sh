#!/system/bin/sh

sleep 10
PID=$(ps -A | grep "sec_keyboard" | awk '{ print $2 }')
kill $PID