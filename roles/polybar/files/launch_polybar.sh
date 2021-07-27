#/bin/sh

# Get monitors list
monitors_list=$(xrandr --query | grep " connected" | cut -d" " -f1) 

# Use tray on external monitor if connected, otherwise use laptop

tray_location="eDP-1"

for i in $monitors_list; do 
  if [[ $i == "DP1-1" ]]; then
    tray_location = "DP1-1"
  fi
done

# Launch bars in all connected monitors

if type "xrandr"; then
  for m in $monitors_list; do
    MONITOR=$m polybar top &
    MONITOR=$m polybar bottom &
  done
else
  polybar top &
  polybar bottom &
fi
