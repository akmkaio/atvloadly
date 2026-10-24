#!/usr/bin/env bash
set -Eeuo pipefail

# atvloadly expects /data to be persistent. Home Assistant maps it automatically.
mkdir -p /data /run/dbus /run/avahi-daemon
rm -f /run/dbus/pid /run/avahi-daemon/pid /run/avahi-daemon/socket

if ! pgrep -x dbus-daemon >/dev/null 2>&1; then
  echo "[atvloadly-ha] Starting private system D-Bus..."
  dbus-daemon --system --fork
fi

if id avahi >/dev/null 2>&1; then
  chown avahi:avahi /run/avahi-daemon
fi

echo "[atvloadly-ha] Starting Avahi for local mDNS discovery..."
avahi-daemon --no-chroot --debug &
AVAHI_PID=$!

for _ in $(seq 1 15); do
  if [ -S /run/avahi-daemon/socket ]; then
    break
  fi
  if ! kill -0 "$AVAHI_PID" 2>/dev/null; then
    echo "[atvloadly-ha] ERROR: Avahi exited during startup. Check logs for a port or D-Bus conflict." >&2
    wait "$AVAHI_PID" || true
    exit 1
  fi
  sleep 1
done

if [ ! -S /run/avahi-daemon/socket ]; then
  echo "[atvloadly-ha] ERROR: Avahi socket was not created; cannot continue safely." >&2
  exit 1
fi

export SERVICE_PORT="${SERVICE_PORT:-5533}"
echo "[atvloadly-ha] Starting atvloadly on port ${SERVICE_PORT}..."
exec /entrypoint.sh
