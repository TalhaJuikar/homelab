terraform {
    required_providers {
    proxmox = {
        source = "Telmate/proxmox"
        version = "3.0.1-rc9"
        }
    }
}
provider "proxmox" {
    pm_api_url      = var.pm_url
}