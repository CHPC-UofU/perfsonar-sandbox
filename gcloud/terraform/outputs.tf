
#- Outputs
#

#output "vm_compute_instances" {
#  description = "List of all details for compute instances."
#  value = module.vm_compute_instance.instances_details
#  sensitive = true
#}

output "vpc_name" {
  description = "Virtual Private Cloud (VPC) name."
  value       = google_compute_network.vpc.name
}

output "vpc_subnet_name" {
  description = "Virtual Private Cloud (VPC) subnet name."
  value       = google_compute_subnetwork.vpc_subnet.name
}