#!/bin/bash

echo "Current path: $(pwd)"

read -rp "Type the file path you want to read: " path

clear

if [ -f "$path" ]; then
  cat "$path"
else
  echo "File '$path' not found or cannot be read."
fi

read -rp "Press any key to exit..."
