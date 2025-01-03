terraform {
    required_providers {
        google = {
        source  = "hashicorp/google"
        version = "~> 6.0"
        }
    }
}

provider "google" {
  credentials = file("../../gcp-account.json")
  project = "taxi-144019"
  region  = "us-east5-a"
}

resource "google_compute_firewall" "ingress-rules" {
  name    = "terraform-ingress-rule"
  network = google_compute_network.terraform-computer-network.name
  description = "Creates firewall Ingress rule from Terraform"

  allow {
    protocol = "tcp"
    ports    = ["80", "90-100"]
  }

  source_tags = ["web"]
}

resource "google_compute_firewall" "egress-rules" {
  name    = "terraform-egress-rule"
  network = google_compute_network.terraform-computer-network.name
  description = "Creates firewall Egress rule from Terraform"
  direction = "EGRESS"

  allow {
    protocol = "all"
  }
}

resource "google_compute_network" "terraform-computer-network" {
  name = "terraform-default-network"
  description = "Creates network from Terraform"
}