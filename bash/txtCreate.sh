#!/bin/bash

read -p "Your name: " name
read -p "Subscribe current content? (y/n)" option

if [ "$option" == "y" ]; then
  echo $name > txtCreate.txt
else
  echo $name >> txtCreate.txt
fi

clear

echo "--- List updated ---"
cat txtCreate.txt

read -p "Press any key to close..." x