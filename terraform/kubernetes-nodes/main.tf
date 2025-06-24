module "proxmox_vms" {
  source = "../modules/proxmox-vm"
  
  for_each = var.vms
  
  pve_node         = var.pve_node
  vm_template      = var.vm_template
  nameservers      = var.nameservers
  searchdomain     = var.searchdomain
  ciuser           = var.ciuser
  cipassword       = var.cipassword
  sshkeys          = var.sshkeys
  boot_disk_storage = var.boot_disk_storage
  

  vm_name          = each.value.vm_name
  cores            = each.value.cores
  sockets          = each.value.sockets
  cpu_type         = each.value.cpu_type
  memory           = each.value.memory
  boot_disk_size   = each.value.boot_disk_size
  ipconfig0        = each.value.ipconfig0
  qemu_agent       = each.value.qemu_agent
}
