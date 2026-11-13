#!/system/bin/sh

sleep 10
if ! IFS= read -r PID < /data/vendor/sec_keyboard/pid; then
    exit 0
fi
case "$PID" in
    ''|*[!0-9]*) exit 1 ;;
esac
[ "$PID" -gt 1 ] || exit 1
if ! IFS= read -r NAME < "/proc/$PID/comm"; then
    exit 0
fi
[ "$NAME" = sec_keyboard ] || exit 0
kill "$PID"
