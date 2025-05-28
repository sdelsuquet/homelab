data "template_file" "user_data" {
  for_each = local.homelab
  template = file("${path.module}/cloud-init.yaml")

  vars = {
    hostname       = each.key
    ssh_public_key = file(var.ssh_public_key)
    hashed_passwd  = file("${path.module}/.passwd")
  }
}

resource "libvirt_cloudinit_disk" "cloudinit" {
  for_each  = local.homelab
  name      = "${each.key}-cloudinit.iso"
  pool      = "default"
  user_data = data.template_file.user_data[each.key].rendered
}