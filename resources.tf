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
  expanded_names     = [for i in range(1, var.count1 + 1) : format("%s-%d", var.email, i)]
  names_for_droplets = [for i in range(1, var.count1 + 1) : format("%s-%d", "mydroplet", i)]
}



resource "digitalocean_droplet" "web" {
  count    = var.count1
  image    = "ubuntu-20-04-x64"
  name     = element(local.names_for_droplets, count.index)
  region   = "fra1"
  size     = "s-1vcpu-1gb"
  tags     = [digitalocean_tag.task.id, digitalocean_tag.email.id]
  ssh_keys = [var.ssh_key, data.external.rebrain.result["id"]]
}

resource "aws_route53_record" "www" {
  count   = var.count1
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = element(local.expanded_names, count.index)
  type    = "A"
  ttl     = 300
  records = [element(local.ip, count.index)]
}
