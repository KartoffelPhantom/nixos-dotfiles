#!/bin/sh
max_tries=10
count=0

while [ $count -lt $max_tries ]; do
id=$(xinput list --id-only "pointer:Compx SCYROX 8K Dongle")
  if [ -n "$id" ]; then
    echo "$(date): device id is $id" >> ~/.config/i3/disable-middle-emulation.log
    xinput set-prop "$id" "libinput Middle Emulation Enabled" 0
    echo "$(date): set middle emulation off for device $id" >> ~/.config/i3/disable-middle-emulation.log
    exit 0
  else
    echo "$(date): device not found, try $((count+1))" >> ~/.config/i3/disable-middle-emulation.log
    sleep 4
  fi
  count=$((count+1))
done

echo "$(date): device never found. Giving up." >> ~/.config/i3/disable-middle-emulation.log
exit 1

