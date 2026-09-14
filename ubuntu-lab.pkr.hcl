packer {
  required_plugins {
    qemu = {
      source  = "github.com/hashicorp/qemu"
      version = ">= 1.1.0"
    }
  }
}

source "qemu" "ubuntu-lab-multiflora" {
  vm_name          = "ubuntu-lab-multiflora"
  output_directory = "outputs"
  iso_url          = var.iso_url
  iso_checksum     = var.iso_checksum

  # Build 100% headless, usando aceleração KVM
  headless    = var.headless
  accelerator = var.accelerator
  machine_type = "q35"
  cpu_model    = "host"
  cpus         = var.cpus
  memory       = var.memory

  # Disco de saída em QCOW2
  disk_size      = var.disk_size
  disk_interface = "virtio-scsi"
  format         = "qcow2"
  net_device     = "virtio-net"

  # Serve http/ (meta-data + user-data) para o autoinstall
  http_directory = "http"

  boot_wait = "5s"
  boot_command = [
    "c<wait>",
    "linux /casper/vmlinuz --- autoinstall ip=dhcp ds=nocloud-net\\;seedfrom=http://{{ .HTTPIP }}:{{ .HTTPPort }}/",
    "<enter><wait>",
    "initrd /casper/initrd",
    "<enter><wait>",
    "boot",
    "<enter>"
  ]

  shutdown_command = "sudo shutdown -P now"

  ssh_username = var.ssh_username
  ssh_password = var.ssh_password
  ssh_timeout  = "45m"
}

build {
  name    = "ubuntu-lab-multiflora"
  sources = ["source.qemu.ubuntu-lab-multiflora"]

  provisioner "shell" {
    environment_vars = [
      "DEBIAN_FRONTEND=noninteractive",
      "LAB_USER=${var.ssh_username}",
      "CODE_SERVER_PASSWORD=${var.code_server_password}"
    ]
    scripts = [
      "scripts/00-base.sh",
      "scripts/10-docker.sh",
      "scripts/20-containerlab.sh",
      "scripts/30-code-server.sh",
      "scripts/99-cleanup.sh"
    ]
  }
}