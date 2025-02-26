#!/bin/bash

read -p "Choice the .extension you want to recoursive delete with . (.txt for example): " extension
read -p "Choose the path where the recursive deletion will happen: " path

if [-d "$path"]; then
  find "$path" -type f -name "*$extension" -exec rm -f {} \;
  echo "Files with extension $extension have been deleted from $path."
else
  echo "the path $path does not exist."
fi

read -p "Press any key to close..." x