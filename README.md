# 🛡️ Wazuh + n8n Agentic SOC Automation — Lab Setup

<div align="center">

[![Typing SVG](https://readme-typing-svg.demolab.com?font=Fira+Code&size=22&pause=1000&color=00A9D4&center=true&vCenter=true&width=600&lines=🛡️+AI-Powered+SOC+Automation;🔐+Wazuh+SIEM+%2B+n8n+%2B+Gemini+AI;⚡+Real-time+Alert+Triage;🤖+Auto-Generated+Incident+Reports)](https://git.io/typing-svg)

</div>

> 🛡️ Automated SOC pipeline built on Wazuh, n8n, and Google Gemini AI. Spins up a fully networked threat detection lab with real-time alert triage and AI-generated incident reports — no manual analysis needed. 🤖⚡

![Wazuh](https://img.shields.io/badge/Wazuh-4.12.0-00a9d4?style=for-the-badge)
![n8n](https://img.shields.io/badge/n8n-Workflow_Automation-EA4B71?style=for-the-badge)
![Docker](https://img.shields.io/badge/Docker-Compose-2496ED?style=for-the-badge&logo=docker)
![Shell](https://img.shields.io/badge/Shell-Scripts-89e051?style=for-the-badge&logo=gnu-bash)

---

## 📖 Overview

This repo gets your lab environment up and running fast. It handles everything from installing Docker to spinning up a fully networked Wazuh + n8n stack — so you can focus on building the AI agentic SOC pipeline.

**Stack:**
- 🔐 **Wazuh 4.12.0** — open-source SIEM for real-time threat detection and alert management
- ⚙️ **n8n** — workflow automation platform running in Docker, connected to Wazuh via a shared `soc-net` network
- 🤖 **Google Gemini AI** — the LLM powering the agentic SOC analyst
- 🧪 **Postman** — for exploring and testing the Wazuh REST APIs

---

## 🗂️ Repository Structure
```
wazuh-n8n-lab-setup/
├── n8n-docker/                     # Docker Compose config for n8n
├── install-docker.sh               # Installs Docker CE + Compose plugin
├── install-postman.sh              # Installs Postman via snap
├── docker-spin-up.sh               # Starts Wazuh + n8n on a shared Docker network
├── docker-spin-down.sh             # Stops Wazuh + n8n containers
└── Wazuh.postman_collection.json   # Full Postman collection for Wazuh APIs
```

---

## 🚀 Setup Guide

### Step 1 — Install Docker
```bash
chmod +x install-docker.sh
./install-docker.sh
```

This script:
- Updates apt packages
- Installs Docker CE, CLI, containerd, and the Compose plugin
- Adds Docker's official GPG key and repo
- Adds your user to the `docker` group so you can run Docker without `sudo`

> ⚠️ Log out and back in (or run `newgrp docker`) after this step for group changes to take effect.

### Step 2 — Install Postman
```bash
chmod +x install-postman.sh
./install-postman.sh
```

Installs Postman via `snap`. Requires `snapd` (installed automatically if missing).

### Step 3 — Spin Up the Lab
```bash
chmod +x docker-spin-up.sh
./docker-spin-up.sh
```

This script does the following automatically:

1. **Creates a shared Docker network** (`soc-net`) — connects Wazuh and n8n so they can communicate
2. **Sets kernel parameter** `vm.max_map_count=262144` required by OpenSearch (Wazuh Indexer)
3. **Clones Wazuh Docker** at pinned version `v4.12.0` (only if not already present)
4. **Generates Indexer SSL certificates** (only on first run)
5. **Starts the Wazuh stack** (manager, indexer, dashboard) via Docker Compose
6. **Connects all Wazuh containers** to the `soc-net` network
7. **Starts n8n** from the `n8n-docker/` directory

| Service | URL | Default Credentials |
|---------|-----|---------------------|
| Wazuh Dashboard | `https://localhost` | `admin / SecretPassword` (change this)|
| n8n | `http://localhost:5678` | Set on first login |
| Wazuh API | `https://localhost:55000` | `wazuh-wui / <password>` |
| Wazuh Indexer | `https://localhost:9200` | `admin / SecretPassword`(change this) |

### Step 4 — Spin Down the Lab
```bash
chmod +x docker-spin-down.sh
./docker-spin-down.sh
```

---

## 🧪 Postman — Wazuh API Collection

Import `Wazuh.postman_collection.json` into Postman, then create an environment with:

| Variable | Value |
|----------|-------|
| `baseUrl-api` | `https://localhost:55000` |
| `baseUrl-Indexer` | `https://localhost:9200` |
| `api-username` | `wazuh-wui` |
| `api-password` | MyS3cr37P450r.*- |
| `Indexer-user` | `admin` |
| `Indexer-password` | `SecretPassword` |

> The collection auto-refreshes your token before the 15-minute expiry.

**Management Server APIs:** Authenticate, List Agents, Manager Info, Syscollector

**Indexer APIs:** Count Alerts, Search Alerts, Search Alerts v1/v2, Search After v2, Endpoint Agg Search, Search Shards, Indices, Indices-Table

---

## 📚 Labs Overview

**Lab 1** — Deploy Wazuh, onboard a Linux agent, explore the dashboard, query APIs with Postman

**Lab 2** — Build n8n HTTP Request workflows to pull Wazuh alerts

**Lab 3 (Final)** — Build the full agentic SOC pipeline in n8n with Gemini AI, memory, and live alert fetching

---

## ⚠️ Prerequisites

| Requirement | Notes |
|-------------|-------|
| Ubuntu 22.04+ | Scripts are Debian/Ubuntu based |
| 8GB+ RAM | Wazuh Indexer is memory-intensive |
| Docker & Compose plugin | Installed via `install-docker.sh` |
| Google Gemini API Key | [Get one here](https://aistudio.google.com/) |
| Postman | Installed via `install-postman.sh` |

---

## 📚 Resources

- [Wazuh Documentation](https://documentation.wazuh.com/)
- [n8n Documentation](https://docs.n8n.io/)
- [Google Gemini API](https://ai.google.dev/)
- [MITRE ATT&CK Framework](https://attack.mitre.org/)

---

⭐ If this helped you, give the repo a star!
