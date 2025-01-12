terraform {
    required_providers {
        google = {
            source = "hashicorp/google"
            version = "~> 6.0"
        }
    }
}

provider "google" {
    credentials = file("../../../gcp-account.json")
    project = "taxi-144019"
    region  = "us-east5-a"
}

resource "google_compute_instance" "vm-instance" {
    name         = "terraform-vm-instance-${count.index}"
    machine_type = "e2-micro" 
    zone         = "us-east5-a"
    count        = 2

    boot_disk {
        initialize_params {
            image = "debian-cloud/debian-11"
        }
    }
    network_interface {
        network = "default"

        access_config {
        // Ephemeral public IP
        }
    }
}