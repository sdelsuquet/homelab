output "vm_names" {
  value = [for vm in libvirt_domain.homelab : vm.name]
}

output "cloud_init" {
  value = [for init in data.template_file.user_data : init.rendered]
}

# output "node_info" {
#   value = {
#     for name, vm in libvirt_domain.homelab : name => {
#       name         = vm.name
#       ip_address   = vm.network_interface[0].addresses[0]
#     }
#   }
# }
