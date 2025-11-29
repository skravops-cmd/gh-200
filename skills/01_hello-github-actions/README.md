# 📝 **README.md**

# 🚀 Terraform Docker Lab  
A clean, modular Terraform project that deploys a small application stack using the Docker provider.

## 🧩 What This Project Demonstrates
- Infrastructure as Code with Terraform  
- Module design and reuse  
- Local Docker provisioning (no cloud costs)  
- CI/CD via GitHub Actions (fmt, validate, plan)  
- Professional repository structure  

## 🏗️ Architecture
```

Docker Engine
└── app_network
├── postgres-db  (PostgreSQL 16)
└── nginx-web    (NGINX reverse proxy)

````

## 🚀 Quick Start

### Install dependencies
- Docker
- Terraform 1.5+
- Make (optional)

### Initialize
```bash
make init
````

### Deploy

```bash
make apply
```

### Destroy

```bash
make destroy
```

## 🔍 Outputs

| Component  | Value                                                    |
| ---------- | -------------------------------------------------------- |
| NGINX      | [http://localhost:8080](http://localhost:8080)           |
| PostgreSQL | postgresql://appuser:secretpassword@localhost:5432/appdb |

## 📦 Modules

This repo includes a reusable container module that:

* Pulls images
* Creates containers
* Manages env vars, ports, and networks

## 🤖 GitHub Actions

Every push runs:

* `terraform fmt`
* `terraform validate`
* `terraform plan`

