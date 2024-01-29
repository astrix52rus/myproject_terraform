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

#Переменная используется для запуска указанного колличества машин

variable "count1" {
  type = number
}

#Выдаем имена дроплетам через переменную names_for_droplets и для днс имен для aws через  expanded_names

locals {
  ip = [for droplet in digitalocean_droplet.web : droplet.ipv4_address]
  expanded_names = [for i in range(1, var.count1 + 1) : format("%s-%d", var.email, i)]
  names_for_droplets = [ for i in range(1, var.count1 + 1) : format("%s-%d", "mydroplet", i)]
}
  
