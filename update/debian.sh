#!/bin/bash

# This script updates the list of packages, installs the latest versions, removes unnecessary packages, and clears the cache

sudo apt update
sudo apt upgrade -y
sudo apt list --upgradable
sudo apt autoremove -y
sudo apt clean
echo "System update completed!"