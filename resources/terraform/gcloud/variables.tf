
#- Variables
#

variable "project_id" {
  description = "The Project ID for the Google Cloud project."
  type        = string
  default     = ""
  sensitive   = true
}

variable "project_number" {
  description = "The Project Number for the Google Cloud project"
  type        = string
  default     = ""
  sensitive   = true
}

variable "region" {
  description = "The region is a specific geographical location where resources are hosted."
  type        = string
  default     = "us-central1"
}

variable "software_stack_name" {
  description = "The name of the software stack."
  type        = string
  default     = "perfsonarsandbox"
}

variable "zone" {
  description = "The zone within a region where resources are hosted."
  type        = string
  default     = "us-central1-c"
}
