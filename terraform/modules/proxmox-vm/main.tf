terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "3.0.1-rc9"
    }
  }
}

resource "proxmox_vm_qemu" "vm" {
    name         = var.vm_name
    target_node  = var.pve_node
    clone        = var.vm_template
    full_clone   = true
    memory       = var.memory
    scsihw       = "virtio-scsi-pci"
    os_type      = "cloud-init"

    boot         = "order=scsi0;ide0"
    ciuser       = var.ciuser
    cipassword   = var.cipassword
    sshkeys      = var.sshkeys
    ciupgrade    = var.package_update
    nameserver   = var.nameservers
    searchdomain = var.searchdomain
    ipconfig0    = var.ipconfig0
    agent        = var.qemu_agent
    
    cpu {
        cores    = var.cores
        sockets  = var.sockets
        type     = var.cpu_type
    }
    disks {
        scsi {
            scsi0 {
                disk {
                    size     = var.boot_disk_size
                    storage  = var.boot_disk_storage
                    emulatessd = true
                }
            }
        }
        ide {
            ide0 {
                cloudinit {
                    storage  = var.boot_disk_storage
                }
            }
            
        }
    }
    network {
        model    = "virtio"
        bridge   = "vmbr0"
        id       = 0
    }
    serial {
        id       = "0"
        type     = "socket"
    }
}
