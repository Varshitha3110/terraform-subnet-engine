# 🚀 Terraform Subnet Engine

<p align="center">
  <strong>Reusable • Modular • Scalable AWS Networking with Terraform</strong>
</p>

<p align="center">
  <a href="#-overview">Overview</a> •
  <a href="#-architecture">Architecture</a> •
  <a href="#-modules">Modules</a> •
  <a href="#-quick-start">Quick Start</a> •
  <a href="#-configuration">Configuration</a> •
  <a href="#-outputs">Outputs</a>
</p>

---

## 🌐 Overview

**Terraform Subnet Engine** is a modular Infrastructure-as-Code solution designed to simplify the creation and management of AWS networking infrastructure.

Instead of maintaining one large Terraform configuration, the infrastructure is divided into reusable modules for:

- 🌐 VPC management
- 🔗 Networking configuration
- 🔐 Security Groups
- 🧩 Subnet management
- ⚙️ Centralized infrastructure configuration

The modular architecture makes the project easier to **reuse, maintain, scale, and extend** across multiple AWS environments.

---

## ✨ Key Features

| Feature | Description |
|---|---|
| 🧩 **Modular Architecture** | Infrastructure is divided into reusable Terraform modules |
| 🌐 **VPC Management** | Dedicated module for VPC infrastructure |
| 🔗 **Networking** | Centralized networking configuration |
| 🔐 **Security Groups** | Reusable security group definitions |
| 🧱 **Subnet Engine** | Structured subnet provisioning and management |
| ♻️ **Reusable** | Modules can be reused across environments |
| ⚙️ **Infrastructure as Code** | Fully managed using Terraform |
| 📦 **State Management** | Terraform state tracks deployed resources |
| 🔧 **Configurable** | Infrastructure can be customized through variables |
| 🚀 **Scalable** | Designed to support future networking components |

---

# 🏗️ Architecture

The project follows a layered Terraform architecture:

```text
                        ┌─────────────────────────┐
                        │     Terraform Root      │
                        │       Configuration     │
                        └────────────┬────────────┘
                                     │
                    ┌────────────────┼────────────────┐
                    │                │                │
                    ▼                ▼                ▼
             ┌────────────┐   ┌────────────┐   ┌──────────────┐
             │    VPC     │   │ Networking │   │   Security   │
             │   Module   │   │   Module   │   │    Groups    │
             └─────┬──────┘   └─────┬──────┘   └──────┬───────┘
                   │                │                  │
                   └────────────────┼──────────────────┘
                                    │
                                    ▼
                           ┌─────────────────┐
                           │  Subnet Engine  │
                           │     Module      │
                           └────────┬────────┘
                                    │
                                    ▼
                           ┌─────────────────┐
                           │   AWS Network   │
                           │  Infrastructure │
                           └─────────────────┘
