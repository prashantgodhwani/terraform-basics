variable "machine_type" {
  description = "Machine type for the VM instance"
  type        = string
}

variable "direction" {
  description = "Direction of the firewall rule"
  type        = string
}

variable "protocol" {
  description = "Protocol of the firewall rule"
  type        = string
}

variable "ports" {
  description = "Ports to open"
  type        = list(string)
}