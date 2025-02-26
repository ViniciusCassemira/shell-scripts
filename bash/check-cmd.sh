#!/bin/bash
echo "Welcome $(whoami)"

read -p "Enter the command you want to check: " version

result=$($version --version 2>/dev/null || $version -v 2>/dev/null)

if [ -z "$result" ]; then
  clear
  echo "$version not found"

  read -p "Do you want to install $version? (y/n) " x
  if [ "$x" == "y" ]; then
    echo "Installing $version..."
    sudo apt install -y $version
  else
    echo "Installation skipped."
  fi
else
  echo "$result"
fi

read -p "Press any key to exit..." x
