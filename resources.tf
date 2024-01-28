
resource "digitalocean_tag" "task" {
    name = var.task
}

resource "digitalocean_tag" "email" {
    name = var.email
}

data "external" "rebrain" {
 program = ["bash", "${path.module}/script.sh"]
}


resource "digitalocean_droplet" "web" {
  image  = "ubuntu-20-04-x64"
  name   = "web-1"
  region = "fra1"
  size   = "s-1vcpu-1gb"
  tags   = [digitalocean_tag.task.id, digitalocean_tag.email.id]
  ssh_keys = [var.ssh_key, data.external.rebrain.result["id"]]
}


