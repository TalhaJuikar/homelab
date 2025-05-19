output "vm_ids" {
  description = "IDs of the created VMs"
  value       = { for k, v in module.proxmox_vms : k => v.vm_id }
}

output "vm_names" {
  description = "Names of the created VMs"
  value       = { for k, v in module.proxmox_vms : k => v.vm_name }
}

output "vm_ips" {
  description = "IP addresses of the created VMs"
  value       = { for k, v in module.proxmox_vms : k => v.vm_ip }
}
