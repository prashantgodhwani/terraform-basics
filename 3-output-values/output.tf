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
    name         = "terraform-vm-instance"
    machine_type = "e2-medium"
    zone         = "us-east5-a"

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

# output "terraform_vm_ip" {
#   value = "https://${google_compute_instance.vm-instance.network_interface.0.access_config.0.nat_ip}:8080"
# }

output "terraform_vm_ip" {
  value = google_compute_instance.vm-instance.network_interface
}