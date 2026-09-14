variable "iso_url" {
  type        = string
  default     = "https://releases.ubuntu.com/24.04/ubuntu-24.04.3-live-server-amd64.iso"
  description = "ISO do Ubuntu Server. Atualize se a versão mudar (veja releases.ubuntu.com/noble/)."
}

variable "iso_checksum" {
  type        = string
  default     = "none"
  description = "Recomendado: sha256:<hash> (obtenha em https://releases.ubuntu.com/noble/SHA256SUMS)."
}

variable "ssh_username" {
  type    = string
  default = "labuser"
}

variable "ssh_password" {
  type      = string
  default   = "1234"
  sensitive = true
}

variable "code_server_password" {
  type      = string
  default   = "1234"
  sensitive = true
}

variable "cpus" {
  type    = number
  default = 4
}

variable "memory" {
  type        = string
  default     = "8192" # MB
  description = "Memória da VM durante o build."
}

variable "disk_size" {
  type    = string
  default = "20G"
}

variable "headless" {
  type    = bool
  default = true
}

variable "accelerator" {
  type        = string
  default     = "kvm"
  description = "Use 'tcg' apenas se não houver KVM (build muito mais lento)."
}