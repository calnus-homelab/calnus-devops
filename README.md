# calnus-devops DevOps
# 🚀 Project: Proxmox Homelab + Terraform

Welcome to this project where we will build a **complete homelab** based on [Proxmox VE](https://www.proxmox.com/en/proxmox-ve), managed through Terraform, deploying multimedia, monitoring, and virtualization services.

---

## 🖥️ Server Hardware

![Physical Server](docs/SOSSR_Logo.webp)

**Server specifications:**

- **CPU**: Quad-Core (4 physical cores)  
- **RAM**: 16 GB DDR4  
- **Storage:**
  - **5 SSDs** of 900 GB (RAID Z1 - ZFS)  
  - **2 NVMe** of 4 TB (for high-performance VMs)  

---

## ⚙️ Project Objectives

1. Install and configure **Proxmox VE** on the physical server.  
2. Use **Terraform** to automate the creation of multiple virtual machines.  
3. Deploy essential services for entertainment, development, and monitoring.  
4. Manage a **Harvester cluster** consisting of **3 nodes**, each with **12 cores**, **16 GB RAM**, and **512 GB storage** for **Longhorn**.  
5. Orchestrate all infrastructure with Terraform and **CI/CD pipelines using GitHub Actions and a self hosted Runner**.  

---

## 🧱 Automated Infrastructure with Terraform

Terraform will:

- Provision VMs in Proxmox and the Harvester cluster.  
- Apply basic configuration (cloud-init with SSH keys).  

---

## 📦 Services to Be Deployed

| Service         | Description                                        |
|----------------|---------------------------------------------------|
| **Jellyfin**    | Multimedia streaming server.                     |
| **Whale**       | Self-hosted music player and server.             |
| **Windows VM**  | Graphical environment for testing or Windows-only apps. |
| **Prometheus**  | Resource and metrics monitoring.                 |
| **Grafana**     | Visual dashboards for metrics.                   |
| **ELK Stack**   | Elasticsearch + Logstash + Kibana for log management. |

---

## 📁 Project Structure

*(Include your project directories, Terraform configs, and scripts here.)*

Additionally:

- Domains have been registered and configured.  
- Proxy settings are managed in the `cloudflare` folder.  
- Detailed configuration for this part using Terraform, including **CI/CD with GitHub Actions** and a **self-hosted GitHub Runner**, can be found in: [cloudflare/README.md](../cloudflare/README.md)