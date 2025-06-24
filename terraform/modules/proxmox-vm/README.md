# Proxmox VM Terraform Module

This module provides a way to create one or multiple virtual machines in Proxmox using Terraform.

## Module Usage

### Basic Usage

```hcl
module "proxmox_vms" {
  source = "../modules/proxmox-vm"
  
  for_each = var.vms
  
  # Common variables
  pve_node         = var.pve_node
  vm_template      = var.vm_template
  nameservers      = var.nameservers
  searchdomain     = var.searchdomain
  ciuser           = var.ciuser
  cipassword       = var.cipassword
  sshkeys          = var.sshkeys
  boot_disk_storage = var.boot_disk_storage
  
  # VM specific variables
  vm_name          = each.value.vm_name
  cores            = each.value.cores
  sockets          = each.value.sockets
  cpu_type         = each.value.cpu_type
  memory           = each.value.memory
  boot_disk_size   = each.value.boot_disk_size
  ipconfig0        = each.value.ipconfig0
  qemu_agent       = each.value.qemu_agent
}
```

## Variables

### Required Variables

| Name | Description |
|------|-------------|
| pve_node | The name of the Proxmox node |
| vm_template | The name of the VM template to clone |
| vm_name | The name of the VM to create |
| boot_disk_storage | The storage location for the boot disk |
| boot_disk_size | The size of the boot disk (e.g., "32G") |
| nameservers | Nameservers to use |
| searchdomain | Search domain to use |
| ciuser | Cloud-init username |
| cipassword | Cloud-init password |
| sshkeys | SSH public keys |

### Optional Variables

| Name | Description | Default |
|------|-------------|---------|
| cores | Number of CPU cores | 2 |
| sockets | Number of CPU sockets | 1 |
| cpu_type | CPU type | "host" |
| memory | Memory size in MB | 2048 |
| ipconfig0 | IP configuration | "ip=dhcp" |
| qemu_agent | Enable QEMU agent | 1 |

## Outputs

| Name | Description |
|------|-------------|
| vm_id | The ID of the VM |
| vm_name | The name of the VM |
| vm_ip | The IP address of the VM |
