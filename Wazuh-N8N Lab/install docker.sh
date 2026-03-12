#!/usr/bin/env bash
set -euo pipefail

echo -e "\e[1;34m"
echo "  ==========================================="
echo "   🐳  Akhil's script is installing Docker..."
echo "             Please wait!"
echo "  ==========================================="
echo -e "\e[0m"

# Update and upgrade all existing packages
sudo apt update && sudo apt upgrade -y

# Install required dependencies for adding Docker's repo over HTTPS
sudo apt install -y ca-certificates curl gnupg lsb-release

# Create the directory for storing apt keyrings if it doesn't exist
sudo mkdir -p /etc/apt/keyrings

# Download Docker's official GPG key and save it in the keyrings directory
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Add Docker's official apt repository for the current Ubuntu version
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
  | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update apt to include the newly added Docker repository
sudo apt update

# Install Docker Engine, CLI, containerd, and the Compose plugin
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

# Add the current user to the docker group to run Docker without sudo
sudo usermod -aG docker $USER

# Apply the group change immediately without needing to log out
newgrp docker

echo ""
echo -e "\e[1;32m  ✅  Docker installed successfully! You're ready to go.\e[0m"
echo -e "\e[1;33m  ⚠️   If docker commands still need sudo, log out and back in.\e[0m"
echo ""