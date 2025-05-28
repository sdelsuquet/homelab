resource "libvirt_volume" "rootfs_base" {
  for_each = local.homelab
  name     = "${each.key}.${var.img_format}"
  pool     = "default"
  source   = var.img_source
  format   = var.img_format
}

resource "libvirt_volume" "rootfs" {
  for_each       = local.homelab
  name           = "${each.key}-resized.${var.img_format}"
  pool           = "default"
  base_volume_id = libvirt_volume.rootfs_base[each.key].id
  size           = var.disk_size
}