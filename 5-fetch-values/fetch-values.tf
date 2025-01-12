variable machine_type_map {
  type = map(string)
  default = {
    us-east5 = "e2-mirco"
    us-central1 = "e2-small"
  }
}

variable machine_type_list {
  type = list(string)
  default = [ "e2-micro", "e2-small" ]
}

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
    # machine_type = var.machine_type_map["us-central1"] ---- Map Implementation
    machine_type = var.machine_type_list[0] # List Implementation
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