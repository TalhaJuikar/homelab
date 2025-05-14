# FluxCD GitOps Configuration

This repository contains the GitOps configuration for Kubernetes clusters managed through FluxCD, implementing the infrastructure-as-code approach for declarative and automated cluster management.

## Repository Structure

```
fluxcd/
├── apps/                # Application workloads and deployments
│   ├── it-tools/        # IT Tools application manifests
│   ├── jenkins/         # Jenkins CI/CD platform configuration
│   ├── kubernetes-dashboard/ # Kubernetes Dashboard deployment
│   ├── jellyfin/        # Jellyfin media server configuration
│   └── portfolio/       # Portfolio application with image automation
├── clusters/            # Cluster-specific configuration
│   └── homelab/         # Homelab Kubernetes cluster
│       ├── apps/        # App workload definitions for this cluster
│       ├── flux-system/  # Core FluxCD components (auto-generated)
│       ├── infrastructure/ # Infrastructure component declarations
│       └── monitoring/  # Monitoring stack configuration
├── infrastructure/      # Core infrastructure components
│   ├── cloudflare-tunnel-ingress-controller/ # Cloudflare Tunnels for ingress
│   ├── external-secrets/ # External secrets management
│   │   ├── bitwarden-secrets-manager/ # Bitwarden as secrets backend
│   │   └── operator/    # External Secrets Operator configuration
│   └── longhorn-system/ # Longhorn persistent storage system
├── monitoring/          # Observability components
│   ├── dashboards/      # Grafana dashboard configurations
│   ├── kube-prometheus-stack/ # Prometheus monitoring stack
│   ├── loki/            # Loki log aggregation system
│   └── promtail/        # Promtail log collection agent
└── disabled/            # Archived or disabled configurations
```

## Architecture

This repository implements a GitOps approach using FluxCD to manage Kubernetes resources:

1. **Infrastructure Layer** - Core components that provide foundational services:
   - Longhorn for distributed storage
   - External Secrets Operator for secrets management
   - Cloudflare Tunnel for secure ingress

2. **Application Layer** - Workloads deployed on top of infrastructure:
   - Jenkins for CI/CD pipelines
   - Kubernetes Dashboard for cluster visualization
   - Various application workloads with their configurations

3. **Monitoring Layer** - Observability stack:
   - Prometheus and Grafana for metrics collection and visualization
   - Loki and Promtail for log aggregation

## Deployment Flow

FluxCD continuously reconciles the desired state in this repository with the actual state in the Kubernetes cluster:

1. FluxCD monitors the Git repository for changes
2. When changes are detected, FluxCD applies them to the cluster
3. Dependencies are handled through kustomization ordering:
   - Infrastructure components are deployed first
   - Applications and monitoring components follow

## Usage Guidelines

### Adding New Applications

1. Create application manifests in the `apps/` directory
2. Reference the application in the appropriate cluster's `apps/kustomization.yaml`
3. Commit and push changes to trigger automatic deployment

### Modifying Infrastructure

1. Edit the relevant components in the `infrastructure/` directory
2. Update dependencies in the appropriate kustomization files
3. Commit and push changes for automatic reconciliation

### Troubleshooting

If reconciliation issues occur:
- Check FluxCD logs: `kubectl logs -n flux-system deployment/source-controller`
- Verify kustomization status: `kubectl get kustomizations -A`
- Inspect events: `kubectl get events -A --sort-by='.lastTimestamp'`

## Security Considerations

- Sensitive information is managed via External Secrets Operator
- Bitwarden is used as the secrets backend
- Authentication for services is handled through basic auth or service-specific methods

## Prerequisites

- Kubernetes cluster with FluxCD installed
- SSH key with access to this Git repository
- Bitwarden account configured for External Secrets
