variable "pve_node" {
    description = "Proxmox Node"
    type        = string
}

variable "vm_template" {
    description = "VM Template"
    type        = string
}

variable "vm_name" {
    description = "VM Name, also will be used as hostname"
    type        = string
}

variable "cores" {
    description = "Number of CPU cores"
    type        = number
    default     = 2
}

variable "sockets" {
    description = "Number of CPU sockets"
    type        = number
    default = 1
}

variable "cpu_type" {
    description = "CPU type"
    type        = string
    default     = "host"
}

variable "memory" {
    description = "Memory size in MB"
    type        = number
    default     = 2048
}

variable "boot_disk_storage" {
    description = "Boot disk storage"
    type        = string
}

variable "boot_disk_size" {
    description = "Boot disk size"
    type        = string
}

variable "ipconfig0" {
    description = "IP configuration, for static IP use: [gw=<GatewayIPv4>,ip=<IPv4>]"
    type        = string
    default = "ip=dhcp"
}

variable "qemu_agent" {
    description = "QEMU agent"
    type        = number
    default     = 1
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

variable "package_update" {
    description = "Update packages"
    type        = bool
    default     = true
}