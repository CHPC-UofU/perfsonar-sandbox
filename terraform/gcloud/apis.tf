
#- Google Cloud Services (APIs)
#
# Resources:
# * https://registry.terraform.io/modules/terraform-google-modules/project-factory/google/latest/submodules/project_services

module "enabled_google_apis" {
  source  = "terraform-google-modules/project-factory/google//modules/project_services"
  version = "~>14.2.0"

  project_id = var.project_id
  disable_services_on_destroy = false

  activate_apis = [
    "cloudapis.googleapis.com",
    "clouddebugger.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "compute.googleapis.com",
    "iam.googleapis.com",
    "iamcredentials.googleapis.com",
    "logging.googleapis.com",
    "oslogin.googleapis.com",
    "storage-api.googleapis.com",
    "storage-component.googleapis.com",
    "storage.googleapis.com"
  ]
}
