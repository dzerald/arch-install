#/bin/sh

monitors=$(xrandr | grep -sw 'connected' | cut -d " " -f 1)

unset laptop external_1 external_2 || true

for monitor in $monitors
do
  if [[ "$monitor" == "eDP1" ]]; then
    laptop=yes
  elif [[ "$monitor" == "DP1-1" ]]; then
    external_1=yes
  elif [[ "$monitor" == "DP1-3" ]]; then
    external_2=yes
  fi
done
