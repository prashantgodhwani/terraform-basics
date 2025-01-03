terraform {
    required_providers {
        google = {
            source = "hashicorp/google"
            version = "~> 6.0"
        }
    }
}

provider "google" {
    credentials = file("../../gcp-account.json")
    project = "taxi-144019"
    region  = "us-east5-a"
}

resource "google_compute_instance" "vm-instance" {
    name         = "terraform-vm-instance"
    machine_type = "e2-medium"
    zone         = "us-east5-a"

    boot_disk {
        initialize_params {
            image = "debian-cloud/debian-11"
        }
    }

    network_interface {
        network = google_compute_network.tf_vpc_network.id

        access_config {
        // Ephemeral public IP
        }
    }
}

resource "google_compute_network" "tf_vpc_network" {
  name = "tf-vpc-network"
}

resource "google_compute_firewall" "terraform-firewall" {
    name    = "terraform-firewall-rule"
    network = google_compute_network.tf_vpc_network.id
    description = "Creates firewall rule from Terraform"
    direction = "INGRESS"

    allow {
        protocol = "tcp"
        ports    = ["443"]
    }
    source_ranges = [google_compute_instance.vm-instance.network_interface.0.access_config.0.nat_ip]
    source_tags = ["web"]
}