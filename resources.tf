
resource "digitalocean_tag" "task" {
    name = var.task
}

resource "digitalocean_tag" "email" {
    name = var.email
}

data "external" "rebrain" {
 program = ["bash", "${path.module}/script.sh"]
 query = {
    arg1 = var.token
 }
}

data "aws_route53_zone" "selected" {
  name = "devops.rebrain.srwx.net"
}  

resource "digitalocean_droplet" "web" {
  image  = "ubuntu-20-04-x64"
  name   = "web-1"
  region = "fra1"
  size   = "s-1vcpu-1gb"
  tags   = [digitalocean_tag.task.id, digitalocean_tag.email.id]
  ssh_keys = [var.ssh_key, data.external.rebrain.result["id"]]
}

resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "raririri1245@gmail.com.devops.rebrain.srwx.net"
  type    = "A"
  ttl     = 300
  records = [digitalocean_droplet.web.ipv4_address]
}
