
#- Google Cloud Virtual Private Cloud (VPC)
#
#  Resources:
#  * https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network
#  * https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork

resource "google_compute_network" "vpc" {
  name                    = "${var.software_stack_name}-vpc"
  project                 = module.enabled_google_apis.project_id
  routing_mode            = "REGIONAL"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "vpc_subnet" {
  name                       = "${google_compute_network.vpc.name}-${var.region}"
  project                    = module.enabled_google_apis.project_id
  ip_cidr_range              = "10.128.0.0/9"
  region                     = var.region
  stack_type                 = "IPV4_IPV6"
  ipv6_access_type           = "EXTERNAL"
  network                    = google_compute_network.vpc.name
  private_ip_google_access   = true
  private_ipv6_google_access = "DISABLE_GOOGLE_ACCESS"
  purpose                    = "PRIVATE"
}

#- Google Cloud Routers
#
# Resources:
# * https://registry.terraform.io/modules/terraform-google-modules/cloud-router/google/latest

module "vpc_router" {
  source  = "terraform-google-modules/cloud-router/google"
  version = "~>5.0.0"

  project = module.enabled_google_apis.project_id
  name    = "${var.software_stack_name}-vpc-router"
  network = google_compute_network.vpc.name
  region  = var.region

  nats = [
    {
    name = "${var.software_stack_name}-vpc-gateway"
    }
  ]
}
