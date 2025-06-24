variable "pm_url" {
    description = "Proxmox API URL"
    type        = string
}

variable "pve_node" {
    description = "Proxmox Node"
    type        = string
}

variable "vm_template" {
    description = "VM Template"
    type        = string
}

variable "nameservers" {
    description = "Nameserver"
    type        = string
}

variable "searchdomain" {
    description = "Search domain"
    type        = string
}

variable "ciuser" {
    description = "Cloud-init user"
    type        = string
}

variable "cipassword" {
    description = "Cloud-init password"
    type        = string
}

variable "sshkeys" {
    description = "SSH keys"
    type        = string
}

variable "boot_disk_storage" {
    description = "Boot disk storage"
    type        = string
}

variable "package_update" {
    description = "Update packages"
    type        = bool
    default     = true
}

variable "vms" {
  description = "Map of VM configurations"
  type = map(object({
    vm_name        = string
    cores          = optional(number, 2)
    sockets        = optional(number, 1)
    cpu_type       = optional(string, "host")
    memory         = optional(number, 2048)
    boot_disk_size = string
    ipconfig0      = optional(string, "ip=dhcp")
    qemu_agent     = optional(number, 1)
  }))
}
