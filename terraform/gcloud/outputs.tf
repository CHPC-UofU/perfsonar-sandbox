
#- Outputs
#

output "vpc_name" {
  description = "Virtual Private Cloud (VPC) name."
  value       = google_compute_network.vpc.name
}

output "vpc_subnet_name" {
  description = "Virtual Private Cloud (VPC) subnet name."
  value       = google_compute_subnetwork.vpc_subnet.name
}