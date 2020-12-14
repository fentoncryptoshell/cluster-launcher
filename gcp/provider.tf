terraform {
  required_version = ">= 0.13"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.50.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = local.region
}
