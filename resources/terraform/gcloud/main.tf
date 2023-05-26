
#- Data
#

# Retrieve an access token as the Terraform runner
data "google_client_config" "default" {}

#- Locals
#

#- Modules
#

module "tfstate-bucket" {
  source  = "./modules/tfstate-bucket"

  project_id = var.project_id
}
