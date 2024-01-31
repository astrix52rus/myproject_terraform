terraform {
  required_providers {
    external = {
      source  = "hashicorp/external"
      version = "2.2.2"
    }

    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "2.34.1"
    }

    aws = {
      source  = "hashicorp/aws"
      version = "5.34.0"
    }

    random = {
      source = "hashicorp/random"
      version = "3.6.0"
    }
  }
}



provider "digitalocean" {
  token = var.token
}

provider "external" {}

provider "aws" {
  region     = "eu-west-1"
  access_key = var.access_key
  secret_key = var.secret_key
}

provider "random" {}
