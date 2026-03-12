#!/usr/bin/env bash
set -euo pipefail

echo -e "\e[1;31m"
echo "  ==========================================="
echo "   🔻  Akhil's script is shutting down..."
echo "             Please wait!"
echo "  ==========================================="
echo -e "\e[0m"

# Stop Wazuh
cd ./wazuh-docker/single-node
sudo docker compose down

# Stop n8n
cd ../../n8n-docker
sudo docker compose down

echo ""
echo -e "\e[1;32m  ✅  All done! Wazuh + n8n have been shut down cleanly.\e[0m"
echo ""