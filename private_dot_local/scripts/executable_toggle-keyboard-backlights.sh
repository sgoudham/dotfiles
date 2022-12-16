#!/bin/bash

OFF=0
ON=2
KEYBOARD_PATH=/sys/devices/platform/dell-laptop/leds/dell::kbd_backlight/brightness
PREVIOUS_SETTING=$(< $KEYBOARD_PATH)

if [[ $PREVIOUS_SETTING -eq $OFF ]]
then
  echo $ON > $KEYBOARD_PATH
  echo "Keyboard Backlighting: ON"
else
  echo $OFF > $KEYBOARD_PATH
  echo "Keyboard Backlighting: OFF"
fi
