
#- Google Cloud Compute Instance Templates
#
# Resources:
# * https://registry.terraform.io/modules/terraform-google-modules/vm/google/latest/submodules/instance_template

module "vm_instance_template" {
  source  = "terraform-google-modules/vm/google//modules/instance_template"
  version = "~>8.0.1"

  name_prefix     = "${var.software_stack_name}-instance-template"
  labels          = { environment = "dev" }
  project_id      = module.enabled_google_apis.project_id
  region          = var.region
  service_account = {
    email  = "${var.project_number}-compute@developer.gserviceaccount.com"
    scopes = [
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring.write",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/trace.append"
    ]
  }
  subnetwork      = google_compute_subnetwork.vpc_subnet.name

}

#- Google Cloud Compute Instances
#
# Resources:
# * https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance
# *

module "vm_compute_instance" {
  source  = "terraform-google-modules/vm/google//modules/compute_instance"
  version = "~>8.0.1"

  instance_template     = module.vm_instance_template.name
  num_instances         = var.num_instances
  region                = var.region
  subnetwork            = google_compute_subnetwork.vpc_subnet.name
  subnetwork_project    = module.enabled_google_apis.project_id
  zone                  = var.zone
}