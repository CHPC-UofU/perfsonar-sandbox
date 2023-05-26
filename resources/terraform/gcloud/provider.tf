
#- Providers
#
# Resources:
# * https://registry.terraform.io/providers/hashicorp/google/latest/docs
# * https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs

provider "google" {
  project               = var.project_id
  region                = var.region
  zone                  = var.zone

  # Resource: https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference#user_project_override
  user_project_override = true
}
