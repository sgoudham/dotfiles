#!/bin/bash

gsettings set org.gnome.mutter dynamic-workspaces true
gsettings set org.gnome.desktop.wm.preferences num-workspaces 4
for i in {1..12} 
do
  gsettings set "org.gnome.desktop.wm.keybindings" "switch-to-workspace-$i" "[]"
  gsettings set "org.gnome.desktop.wm.keybindings" "move-to-workspace-$i" "[]"
done

