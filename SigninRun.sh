#!/bin/bash

#Tells the computer to open a terminal window
gnome-terminal
#Waits 10 Seconds
sleep 10
#Types ./frc4123signin.sh into the shell
xdotool type './frc4123signin.sh'
#Waits 2 seconds
sleep 2
#Executes frc4123signin.sh by pressing enter
xdotool key KP_Enter
