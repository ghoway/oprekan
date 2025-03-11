#!/bin/bash

TARGET_IP="8.8.8.8" # Ganti dengan IP atau host yang Anda ingin ping
TIMEOUT=5

while true
do
  if ! ping -c 1 -W $TIMEOUT $TARGET_IP > /dev/null; then
    echo "RTO terjadi, mengaktifkan mode pesawat..."
    settings put global airplane_mode_on 1
    am broadcast -a android.intent.action.AIRPLANE_MODE --ez state true
    sleep 2
    echo "Memastikan hotspot tetap aktif..."
    svc wifi enable
    svc wifi tethering enable
    settings put global airplane_mode_on 0
    am broadcast -a android.intent.action.AIRPLANE_MODE --ez state false
    sleep 10
  else
    echo "Ping berhasil, tidak ada tindakan."
    sleep 5
  fi
done
