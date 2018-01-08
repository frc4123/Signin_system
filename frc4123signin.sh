#!/bin/bash

#Written by Adrian Campos '16. Translated into bash 
#and improved by Trevor Peitzman '19 for Tribe Robotics
#FRC team 4123 of Saint John Bosco High School.
#Created 07/10/2016
#Last Revised 01/08/2017


#Init function to call for signing in and or out

status () {

  #
  echo -ne "${LBLU}Scan Student ID Barcode to sign ${YLW}$inorout${LBLU}>${NC} " #"$inorout"> "
  read id

  if [ "$id" = "4123KEY_IN" ]; then 
	inorout="In"
	echo "The mode has been set to sign-in."
	status

  elif [ "$id" = "4123KEY_OUT" ]; then
	inorout="Out"
	echo "The mode has been set to sign-out."
	status
  
  elif [ "$id" = "4123KEY_ID" ]; then
	
	if [ "$inorout" = "In" ]; then
		opnclse="started"
	elif [ "$inorout" = "Out" ]; then
		opnclse="ended"
	else
		echo Something is very wrong. Please contact a programmer.
	fi

	echo "You have just" $opnclse "a meeting. Thank you for your leadership."
	curl -s "https://docs.google.com/forms/d/1P2WXn_4jarH4folreSVn2rj66i_e1mdQJUC0AG7r5Wg/formResponse?ifq&entry.852535003=$id&entry.1927113828=$inorout&submit=Submit" > /dev/null
	
  
  elif [ "$id" = "exit" ]; then
  	exit
  
  # Check that it's an ID by ensuring it's fewer than 6 characters. We'll have to change this by 2096..
  elif ((${#id} > 5)); then
    echo -e "This doesn't seem to be a valid student ID. ${RED}Please try agian.${NC}"

  else
     #Submits a form response to google forms, 
     #which then lands in a spreadsheet in the shared 
     #Tribe Robotics folder. It can be found at 
     #4123_2017/Roster/Backend/attendanceRawData
	curl -s "https://docs.google.com/forms/d/1P2WXn_4jarH4folreSVn2rj66i_e1mdQJUC0AG7r5Wg/formResponse?ifq&entry.852535003=$id&entry.1927113828=$inorout&submit=Submit" > /dev/null
	echo -e "Signed ${YLW}$id $inorout${NC}. Thank you and have a pleasant day."
  fi

#Loops the whole thing all over again
status

}

#Begin body code

#gnome-terminal --window --full-screen

RED='\033[1;91m'
YLW='\e[38;5;184m'
LBLU='\033[0;34m'
NC='\033[0m'

#Renames terminal window to "Tribe Robotics Signin System"
echo -ne "\033]0;Tribe Robotics Signin System\007"

#Default in/out value is 'In'
inorout="In"

xdotool key F11

status


done

