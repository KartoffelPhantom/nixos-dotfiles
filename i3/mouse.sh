#!/bin/sh
sleep 5
id=$(xinput list --id-only "Compx SCYROX 8K Dongle")
if [ -n "$id" ]; then
  xinput set-prop "$id" "libinput Middle Emulation Enabled" 0
fi

