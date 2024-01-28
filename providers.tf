terraform {
  required_providers {
    external = {
      source = "hashicorp/external"
      version = "2.2.2"
    }
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "2.34.1"
    }
  }
}

provider "digitalocean" {
 token = var.token
}

provider "external" {}
