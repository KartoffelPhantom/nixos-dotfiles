#!/bin/sh
sleep 10
id=$(xinput list --id-only "Compx SCYROX 8K Dongle")
echo "$(date): device id is $id" >> ~/.config/i3/disable-middle-emulation.log
if [ -n "$id" ]; then
  xinput set-prop "$id" "libinput Middle Emulation Enabled" 0
  echo "$(date): set middle emulation off for device $id" >> ~/.config/i3/disable-middle-emulation.log
else
  echo "$(date): device not found" >> ~/.config/i3/disable-middle-emulation.log
fi

