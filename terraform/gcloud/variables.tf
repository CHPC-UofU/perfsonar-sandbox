
#- Variables
#

variable "perfsonar_instances" {
  description = <<EOF
asdfasdfasdf
EOF
  type = list(object({
    num_instances = string
    role          = number
  }))
  default = [
    {
      num_instances = 1
      role          = "archive"
    },
    {
      num_instances = 1
      role          = "testpoint"
    },
    {
      num_instances = 1
      role          = "toolkit"
    }
  ]
}



variable "num_testpoint_instances" {
  description = "The number of perfSONAR Testpoint compute instances to create."
  type        = number
  default     = 3
}

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
  default     = "sandbox"
}

variable "source_image_family" {
  description = "The source image family in the associated project."
  type        = string
  default     = "centos-7"
}

variable "source_image_project" {
  description = "The project where the source image comes from."
  type        = string
  default     = "centos-cloud"
}

variable "stack_type" {
  description = "The stack type for the compute instance interfaces to identify whether the IPv6 feature is enabled or not."
  type        = string
  default     = "IPV4_ONLY"
}

variable "zone" {
  description = "The zone within a region where resources are hosted."
  type        = string
  default     = "us-central1-c"
}
