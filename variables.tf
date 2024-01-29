variable "ssh_key" {
  type = string
  sensitive = true
}

variable "email" {
  type = string
}

variable "task" {
  type = string
}

variable "token" {
  type = string
  sensitive = true
}

variable "access_key" {
  type = string
  sensitive = true
}

variable "secret_key" {
  type = string
  sensitive = true
}

locals {
  ip = digitalocean_droplet.web.ipv4_address
}

