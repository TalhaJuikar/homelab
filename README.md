# FluxCD Configuration

This repository contains the GitOps configuration for Kubernetes clusters using FluxCD.

## Directory Structure

```
fluxcd/
├── apps/                # Application workloads
│   ├── it-tools/
│   ├── jenkins/
│   ├── kubernetes-dashboard/
│   └── portfolio/
├── clusters/            # Cluster-specific configuration
│   └── homelab/         # Homelab cluster
│       ├── apps/        # App kustomizations for this cluster
│       ├── flux-system/  # Core FluxCD components
│       ├── infrastructure/ # Infrastructure kustomizations
│       └── monitoring/  # Monitoring kustomizations
├── infrastructure/      # Infrastructure components
│   ├── cloudflare-tunnel-ingress-controller/
│   ├── external-secrets/
│   │   ├── bitwarden-secrets-manager/
│   │   └── operator/
│   └── longhorn-system/
├── monitoring/          # Monitoring components
│   ├── default/
│   │   └── metrics-server/
│   └── monitoring/
│       ├── dashboards/
│       ├── kube-prometheus-stack/
│       ├── loki/
│       └── promtail/
└── old/                 # Archived configurations
```

## Usage

This repository is used with FluxCD to manage Kubernetes resources in a GitOps way.

1. Changes to files in this repository will be automatically applied to the cluster
2. The structure separates concerns into:
   - Infrastructure (core services that other apps depend on)
   - Applications (actual workloads)
   - Monitoring (observability components)

## Dependencies

- Infrastructure components are deployed first
- Applications depend on infrastructure
- Monitoring depends on infrastructure
