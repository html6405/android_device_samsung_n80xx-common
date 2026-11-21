#!/system/bin/sh

# Keep PARAM writes and their state in a dedicated domain and data directory.
# The old script created an empty marker even when the partition write failed.
STATE_DIR=/data/vendor/param
BACKUP=$STATE_DIR/param.bin
MARKER=$STATE_DIR/installed
PARAM_PATH=/dev/block/platform/dw_mmc/by-name/PARAM
IMAGE=/vendor/param.lfs

umask 077

if [ "$(cat "$MARKER" 2>/dev/null)" = n80xx-param-v1 ]; then
    exit 0
fi

if [ ! -s "$IMAGE" ]; then
    echo "PARAM image is missing or empty" >&2
    exit 1
fi

# Preserve the original backup from older builds instead of backing up an
# already modified partition. Publish a new backup only after a complete copy.
if [ ! -s "$BACKUP" ]; then
    if [ -s /data/param.bin ]; then
        dd if=/data/param.bin of="$BACKUP.tmp" bs=4096 || exit 1
    else
        dd if="$PARAM_PATH" of="$BACKUP.tmp" bs=4096 || exit 1
    fi
    mv "$BACKUP.tmp" "$BACKUP" || exit 1
fi

# Install the recovery helper before touching the partition. mksh here-documents
# use /data/local temporary files, which are outside this domain's private data.
printf '%s\n' \
    '#!/system/bin/sh' \
    'BACKUP=/data/vendor/param/param.bin' \
    'PARAM_PATH=/dev/block/platform/dw_mmc/by-name/PARAM' \
    '[ -s "$BACKUP" ] || exit 1' \
    'dd if="$BACKUP" of="$PARAM_PATH" bs=4096 || exit 1' \
    'sync || exit 1' > "$STATE_DIR/restore.sh.tmp" || exit 1
chmod 0700 "$STATE_DIR/restore.sh.tmp" || exit 1
mv "$STATE_DIR/restore.sh.tmp" "$STATE_DIR/restore.sh" || exit 1

dd if="$IMAGE" of="$PARAM_PATH" bs=4096 || exit 1
sync || exit 1
printf '%s\n' n80xx-param-v1 > "$MARKER.tmp" || exit 1
mv "$MARKER.tmp" "$MARKER"
