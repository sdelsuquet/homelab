resource "libvirt_network" "homelab_network" {
  name      = "homelab_network"
  addresses = ["10.47.0.0/24"]
  mode      = "nat"
  autostart = "true"
  dhcp {
    enabled = true
  }
}

resource "libvirt_domain" "homelab" {
  for_each  = local.homelab
  name      = each.key
  memory    = each.value.memory
  vcpu      = each.value.vcpu
  cloudinit = libvirt_cloudinit_disk.cloudinit[each.key].id

  disk {
    volume_id = libvirt_volume.rootfs[each.key].id
  }

  network_interface {
    network_name   = var.network_name
    wait_for_lease = false
  }

  graphics {
    type        = "vnc"
    listen_type = "address"
    autoport    = true
  }

  console {
    type        = "pty"
    target_type = "serial"
    target_port = "0"
  }
}