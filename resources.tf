data "external" "rebrain" {
  program = ["bash", "${path.module}/script.sh"]
  query = {
    arg1 = var.token
  }
}

data "aws_route53_zone" "selected" {
  name = "devops.rebrain.srwx.net"
}

resource "digitalocean_tag" "email" {
  name = var.email
}

resource "digitalocean_tag" "task" {
  name = var.task
}

locals {
  ip                 = digitalocean_droplet.web[*].ipv4_address
  names_for_droplets = [for i in range(1, var.count1 + 1) : format("%s-%d", "mydroplet", i)]
}

resource "local_file" "machine_info_file" {
  filename = var.path_to_info 
  content  = templatefile("${path.module}/machine_info.tpl", {
    ip = local.ip,
    password = random_password.password[*].result,
    fqdn = aws_route53_record.www[*].fqdn
  })
}

resource "random_password" "password" {
  count            = var.count1  
  length           = "6"
  upper            = true
  lower            = true
  special          = false
}

resource "digitalocean_droplet" "web" {
  count    = var.count1
  image    = "ubuntu-20-04-x64"
  name     = element(local.names_for_droplets, count.index)
  region   = "fra1"
  size     = "s-1vcpu-1gb"
  tags     = [digitalocean_tag.task.id, digitalocean_tag.email.id]
  ssh_keys = [var.ssh_key_id, data.external.rebrain.result["id"]] 

connection {
 type        = "ssh"
 user        = "root"
 private_key = file(var.path)
 host        = self.ipv4_address
}

provisioner "remote-exec" {
  inline = [
     "echo 'root:${element(random_password.password[*].result, count.index)}' | sudo chpasswd"
  ]
 }
}

resource "aws_route53_record" "www" {
  count   = var.count1
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = format("%s-%s.devops.rebrain.srwx.net", var.dev[count.index].your_login, var.dev[count.index].prefix)
  type    = "A"
  ttl     = 300
  records = [element(local.ip, count.index)]
}
