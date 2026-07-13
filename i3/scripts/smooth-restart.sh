#!/bin/bash
maim /tmp/i3-restart.png
feh -F /tmp/i3-restart.png &
sleep 0.15
i3-msg restart
