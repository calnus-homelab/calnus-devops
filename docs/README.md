# calnus-devops Dovs
# 🚀 Proyecto: Homelab Proxmox + Terraform

Bienvenido a este proyecto donde construiremos un **homelab completo** basado en [Proxmox VE](https://www.proxmox.com/en/proxmox-ve), controlado mediante Terraform y desplegando servicios multimedia, de monitoreo y virtualización.

---

## 🖥️ Hardware del Servidor

![Servidor físico](imagen1.jpg)

**Especificaciones técnicas del servidor:**

- **CPU**: Quad-Core (4 núcleos físicos)
- **RAM**: 16 GB DDR4
- **Almacenamiento:**
  - **5 SSDs** de 900 GB (RAID Z1 - ZFS)
  - **2 NVMe** de 4 TB (para VMs de alto rendimiento)

---

## ⚙️ Objetivos del Proyecto

1. Instalar y configurar **Proxmox VE** en el servidor físico.
2. Usar **Terraform** para automatizar la creación de múltiples máquinas virtuales.
3. Desplegar servicios esenciales para entretenimiento, desarrollo y monitoreo.

---

## 🧱 Infraestructura Automatizada con Terraform

Terraform se encargará de:

- Provisionar VMs en Proxmox.
- Aplicar configuración básica (cloud-init con claves SSH).
- Integrarse con Ansible o scripts para instalar servicios.

---

## 📦 Servicios que se desplegarán

| Servicio        | Descripción                                       |
|----------------|---------------------------------------------------|
| **Jellyfin**    | Servidor de streaming multimedia.                 |
| **Whale**       | Reproductor y servidor de música autoalojado.     |
| **Windows VM**  | Entorno gráfico para pruebas o apps Win-only.     |
| **Prometheus**  | Monitorización de recursos y métricas.            |
| **Grafana**     | Dashboards visuales para métricas.                |
| **ELK Stack**   | Elasticsearch + Logstash + Kibana para logs.      |

---

## 📁 Estructura del Proyecto

