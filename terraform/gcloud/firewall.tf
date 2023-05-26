
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

resource "google_compute_firewall" "allow_ssh_ipv4" {
  allow {
    ports    = [ "22" ]
    protocol = "tcp"
  }

  description   = "(IPv4) Allows TCP connections from any source to any instance on the network using port 22."
  direction     = "INGRESS"
  disabled      = true
  name          = "${var.software_stack_name}-allow-ssh-ipv4"
  network       = google_compute_network.vpc.name
  priority      = 65534
  project       = module.enabled_google_apis.project_id
  source_ranges = [ "0.0.0.0/0" ]
}

resource "google_compute_firewall" "allow_ssh_ipv6" {
  allow {
    ports    = [ "22" ]
    protocol = "tcp"
  }

  description   = "(IPv6) Allows TCP connections from any source to any instance on the network using port 22."
  direction     = "INGRESS"
  disabled      = true
  name          = "${var.software_stack_name}-allow-ssh-ipv6"
  network       = google_compute_network.vpc.name
  priority      = 65534
  project       = module.enabled_google_apis.project_id
  source_ranges = [ "::/0" ]
}
