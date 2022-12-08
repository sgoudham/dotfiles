#!/bin/bash

OFF=0
ON=2
PATH=/sys/devices/platform/dell-laptop/leds/dell::kbd_backlight/brightness
PREVIOUS_SETTING=$(< $PATH)

if [[ $PREVIOUS_SETTING -eq $OFF ]]
then
  echo $ON > $PATH
  echo "Keyboard Backlighting: ON"
else
  echo $OFF > $PATH
  echo "Keyboard Backlighting: OFF"
fi
