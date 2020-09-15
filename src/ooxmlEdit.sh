#!/bin/bash

# config --- substitute subl for your favorite text editor or ide.

if [ -z "$1" ]; then
	echo "Missing parameter. Usage: "
  echo "ooxmlEdit.sh <infile>"
	exit 
elif [ $1 != "" ]; then
  echo ""
  echo "This script will extract"
  echo -e "\033[1;31m$1\033[0m"
  echo "into folder "
  echo -e "\033[1;31m$1.src\033[0m"
  echo ""
  echo "then attempt to open the folder in Sublime Text"
  echo -e "using terminal alias \033[1;31msubl\033[0m"
  echo "Make edits then return to terminal to re-archive." 
  echo ""
  echo -e "Really edit \033[1;31m$1\033[0m?"
  read -p "(ctrl+c to abort)? (Y/n)" 
  if [ "$REPLY" == "n" ]; then
    exit
  else
    unzip "$1" -d "$1.src"
    echo -e "Open folder \033[1;31m$1.src\033[0m in \033[1;31msubl\033[0m"
    read -p "(Y/n)?"
  if [ "$REPLY" != "n" ]; then
		subl "$1.src"
  else
    read -p "Make the necessary mods... Enter to repack."
	fi
  until [ "$REPLY" == "q" ]
  do
    read -p "New archive filename [q to quit]: ($1.new)"
	  echo $REPLY
    if [ "$REPLY" != "q" ]; then
      cd "$1".src
      zip -r -X ../"$1".new.potx .
      cd ..
    fi
  done
fi
else
	echo "Missing parameter."
fi