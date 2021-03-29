terraform {
  required_version = ">= 0.14"

  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = ">= 1.25"
    }
  }
}

provider "hcloud" {
  token = var.token
}
