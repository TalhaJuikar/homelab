
![Kubernetes](https://img.shields.io/badge/Kubernetes-326CE5?style=for-the-badge&logo=kubernetes&logoColor=white)
![FluxCD](https://img.shields.io/badge/FluxCD-326CE5?style=for-the-badge&logo=flux&logoColor=white)
![Cilium](https://img.shields.io/badge/Cilium-F8C517?style=for-the-badge&logo=cilium&logoColor=black)
![Traefik](https://img.shields.io/badge/Traefik-24A1C1?style=for-the-badge&logo=traefik&logoColor=black)
![Self-Host](https://img.shields.io/badge/SelfHosted-34C1F1?style=for-the-badge&link=https%3A%2F%2Ftalhajuikar.cloud)

## ✨ Introduction

The purpose of my homelab is to learn, experiment, and gain practical experience with modern infrastructure patterns. As a cloud native engineer, I use this setup to test new techniques before implementing them in professional environments. 

Everything is continuously synchronized through FluxCD, giving me a single source of truth and ensuring that my clusters always reflect the state defined in this repository. Built as both a learning platform and production environment, this system provides a robust, repeatable, and secure foundation for running my homelab services and personal projects.

## 🖥️ Clusters

- **Skywalker**: A Talos Linux-based cluster with highly available control planes leveraging Talos's immutable infrastructure model.

## 🚀 Deployed Applications & Services

### Infrastructure Layer

- **Cilium**: eBPF-based CNI for advanced networking, security, and observability. My choice for CNI and the primary CNI across all my clusters
- **Longhorn**: Distributed storage solution providing resilient volumes across my clusters
- **Cert-Manager**: Automatic TLS certificate management for all services
- **External-Secrets**: Securely syncs credentials from Bitwarden to my clusters
- **MetalLB**: Bare metal load balancer that assigns IPs to services on my network
- **Traefik**: Intelligent edge router directing traffic to appropriate services
- **Cloudflare Tunnel**: Secure external access without exposing my home network

### Application Layer

- **Kubernetes Dashboard**: Web UI for visualizing and managing cluster resources
- **Portfolio Website**: My personal website with automated image updates through Flux. [talhajuikar.com](https://talhajuikar.com)
- **IT-Tools**: Collection of some handy utilities I use for daily operations

### Monitoring Stack

- **Prometheus**: Multiple federated instances collecting metrics across clusters
- **Grafana**: Custom dashboards for monitoring system health and application metrics
- **Loki**: Centralized log aggregation for all applications
- **Promtail**: DaemonSet running on every node to collect and ship logs to Loki

### Automated Image Updates

One of my favorite features is the automated image updates for my portfolio website:

1. The Image Automation Controller watches my container registry for new image tags
2. When a new image is detected, Flux automatically:
   - Updates the manifest in the Git repository
   - Commits the change with a standardized message via the Flux CD Bot
   - Applies the updated deployment to the cluster

This creates a fully automated CI/CD pipeline where building a new container image triggers a complete deployment without any manual intervention.

## 🔒 Security Approach

I've implemented several layers of protection:

- **Secrets Management**: I store all sensitive data in Bitwarden and retrieve it dynamically via External Secrets Operator, keeping credentials out of Git. Also I use SOPS to encrypt sensitive files in the repository.
- **Network Security**: I expose services to the internet exclusively through Cloudflare Tunnels, eliminating the need for open inbound ports

## 🔑 Credential Management

Managing secrets is critical in my setup:

- **External Secrets**: I use External Secrets Operator to fetch sensitive data from Bitwarden
- **Secret Rotation**: Regular rotation of credentials for critical services
- **Sealed Secrets**: For cases where I need to commit encrypted secrets to Git


## 💾 Storage Strategy

I use multiple storage solutions based on the specific needs of each application:

- **Longhorn**: Provides distributed block storage for most stateful applications. Also allows me to create snapshots and backups of critical data.
- **Backup Strategy**: Regular snapshots and off-site backups for critical data

## 🔧 Networking Setup

My networking architecture is designed for security and isolation:

- **CNI**: Cilium provides eBPF-based networking across all clusters with advanced security features
- **Ingress**: Traefik handles all incoming traffic with proper routing and TLS termination
- **Service Exposure**: Cloudflare Tunnels provide secure external access without opening ports
- **Load Balancing**: MetalLB assigns LB IPs to services on my internal network
- **Network Policies**: Cilium network policies enforce fine-grained access control between services

## 🛠️ Workflow and Operations

### My Troubleshooting Approach
When issues arise, here's how I diagnose them:
```bash
# I check the Flux controllers for errors
kubectl logs -n flux-system deployment/source-controller

# I verify the status of my resources
kubectl get kustomizations,helmreleases -A

# I look at cluster events for clues
kubectl get events -A --sort-by='.lastTimestamp'
```
I also heavily rely on my Grafana dashboards to monitor resource usage and performance metrics across all applications.

### How I Deploy New Applications
When I want to add a new application to my clusters, I follow these steps:

1. I develop the base manifests in `apps/base/<application-name>/`, typically starting with a deployment, service, and ingress
2. I create cluster-specific overlays in `apps/<cluster-name>/<application-name>/` with configuration unique to each environment
3. I add the application reference to the respective cluster's kustomization in `clusters/<cluster-name>/apps.yaml`
4. After committing and pushing changes, Flux automatically applies the new resources to my clusters

For example, when I added the IT-Tools deployment, I created the base configuration in `apps/base/it-tools/` with deployment, service, and ingressroute manifests, then created cluster-specific overlays in `apps/morpheus/it-tools/` with Morpheus-specific configurations.

### How I Manage Infrastructure Changes

Infrastructure changes follow a similar pattern but require more careful planning:

1. I make changes to core components in `infrastructure/base/<component-name>/`
2. I test major changes on the a temporary dev cluster that I spin up using rancher cluster first before applying to my production clusters
3. I leverage Flux's dependency management to ensure components deploy in the correct order

---

This repository is a living documentation of my journey with Kubernetes and GitOps. As I continue to refine my approach, I'll update the code here to reflect my current followed practices.