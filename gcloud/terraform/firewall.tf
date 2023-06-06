
#- Google Cloud Firewall Rules
#
#  Resources:
#  * https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall

resource "google_compute_firewall" "allow_internal_ipv4" {
  allow {
    protocol = "all"
  }

  description   = "(IPv4) Allows TCP connections from any instance on the network to any other instance on the network."
  direction     = "INGRESS"
  name          = "${var.software_stack_name}-allow-internal-ipv4"
  network       = google_compute_network.vpc.name
  priority      = 65534
  project       = module.enabled_google_apis.project_id
  source_ranges = [ google_compute_subnetwork.vpc_subnet.ip_cidr_range ]
}

resource "google_compute_firewall" "allow_internal_ipv6" {
  allow {
    protocol = "all"
  }

  description   = "(IPv6) Allows TCP connections from any instance on the network to any other instance on the network."
  direction     = "INGRESS"
  name          = "${var.software_stack_name}-allow-internal-ipv6"
  network       = google_compute_network.vpc.name
  priority      = 65534
  project       = module.enabled_google_apis.project_id
  source_ranges = [ google_compute_subnetwork.vpc_subnet.external_ipv6_prefix ]
}

resource "google_compute_firewall" "allow-ingress-from-iap-ipv4" {
  allow {
    ports    = [ "22", "3389" ]
    protocol = "tcp"
  }

  description   = "(IPv4) Allows RDP and SSH connections from Google IAP services to any instance on the network."
  direction     = "INGRESS"
  name          = "${var.software_stack_name}-allow-ingress-from-iap-ipv4"
  network       = google_compute_network.vpc.name
  priority      = 65534
  project       = module.enabled_google_apis.project_id
  source_ranges = [ "35.235.240.0/20" ]
}
