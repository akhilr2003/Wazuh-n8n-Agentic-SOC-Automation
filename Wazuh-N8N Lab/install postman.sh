#!/usr/bin/env bash
set -euo pipefail

echo -e "\e[1;35m"
echo "  ==========================================="
echo "   📮  Akhil's script is installing Postman..."
echo "             Please wait!"
echo "  ==========================================="
echo -e "\e[0m"

# Install snapd package manager if it's not already present
# Snap is required to install Postman on Ubuntu
sudo apt install snapd -y

# Install Postman via snap (official distribution method)
sudo snap install postman

echo ""
echo -e "\e[1;32m  ✅  Postman installed successfully! Launch it from your apps menu.\e[0m"
echo ""