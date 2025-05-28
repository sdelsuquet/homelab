variable "img_source" {
  description = "Link to Fedora Cloud image"
  type        = string
  default     = "https://download.fedoraproject.org/pub/fedora/linux/releases/42/Cloud/x86_64/images/Fedora-Cloud-Base-Generic-42-1.1.x86_64.qcow2"
  # https://cloud.debian.org/images/cloud/bookworm/20250428-2096/debian-12-generic-amd64-20250428-2096.qcow2
  # https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img
}

variable "img_format" {
  description = "QCow2 UEFI/GPT Bootable disk image"
  default     = "qcow2"
  type        = string
}

variable "disk_size" {
  description = "Size of each VM disk in GiB"
  type        = number
  default     = 20 * 1024 * 1024 * 1024
}

variable "vm_definitions" {
  description = "Map of VMs with memory and vCPU settings"
  type = map(object({
    memory = number
    vcpu   = number
  }))
  default = {
    controlplane = {
      memory = 8192
      vcpu   = 4
    }
    node01 = {
      memory = 4096
      vcpu   = 2
    }
    node02 = {
      memory = 4096
      vcpu   = 2
    }
  }
}

variable "network_name" {
  description = "Libvirt network name"
  type        = string
  default     = "homelab_network"
}

variable "ssh_public_key" {
  description = "Path to the SSH public key"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}
